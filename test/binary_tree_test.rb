require_relative 'test_helper.rb'
require './lib/node.rb'
require './lib/binary_tree.rb'

class TestBinarySearchTree < Minitest::Test

  def setup
    @tree = BinarySearchTree.new
    values = {
      61 => "Bill and Ted's Excellent Adventure",
      16 => "Johnny English",
      92 => "Sharknado 3",
      50 => "Hannibal Buress: Animal Furnace"
    }
    values.each do |key, value|
      @tree.insert(key, value)
    end
  end

  def test_binary_tree_initializes
    assert_instance_of BinarySearchTree, @tree
  end

  def test_binary_tree_creates_first_node_at_root
    assert_equal 61, @tree.root.key
  end

  def test_binary_tree_takes_multiple_nodes
    assert_equal 61, @tree.root.key
    assert_equal 16, @tree.root.left.key
    assert_equal 92, @tree.root.right.key
    assert_equal 50, @tree.root.left.right.key
  end

  def test_tree_returns_depth_when_node_inserts
    tree = BinarySearchTree.new
    assert_equal 0, tree.insert(60, "root node")
    assert_equal 1, tree.insert(65, "level 1")
    assert_equal 2, tree.insert(70, "level 2")
  end

  def test_binary_tree_include?
    assert @tree.include?(61)
    assert @tree.include?(16)
    refute @tree.include?(72)
    assert @tree.include?(50)
  end

  def test_binary_tree_calculates_depth
    assert_equal 0, @tree.depth_of(61)
    assert_equal 1, @tree.depth_of(16)
    assert_equal 1, @tree.depth_of(92)
    assert_equal 2, @tree.depth_of(50)
  end

  def test_binary_tree_can_find_max
    test_hash = {"Sharknado 3" => 92}
    assert_equal test_hash, @tree.max
  end

  def test_binary_tree_can_find_min
    test_hash = {"Johnny English" => 16}
    assert_equal test_hash, @tree.min
  end

  def test_binary_tree_sorts_to_hash
    test_array = [
      {16 => "Johnny English"},
      {50 => "Hannibal Buress: Animal Furnace"},
      {61 => "Bill and Ted's Excellent Adventure"},
      {92 => "Sharknado 3"}
    ]
    assert_equal test_array, @tree.sort
  end

  def test_tree_can_load_file
    tree = BinarySearchTree.new
    assert_equal 99, tree.load("./lib/movies.txt")
  end

  def test_tree_transforms_lines
    tree = BinarySearchTree.new
    line_1 = "61, Bill and Ted's Excellent Adventure"
    line_2 = "29, Like Sunday, Like Rain"
    expected_1 = {61 => "Bill and Ted's Excellent Adventure"}
    expected_2 = {29 => "Like Sunday, Like Rain"}
    assert_equal expected_1, tree.transform_line(line_1)
    assert_equal expected_2, tree.transform_line(line_2)
  end

  def test_tree_reads_lines
    tree = BinarySearchTree.new
    file = File.open("./lib/test.txt", 'r')
    expected = [
      {71 => "Hannibal Buress: Animal Furnace"},
      {80 => "Hannibal Buress: Comedy Camisado"},
      {17 => "Meet My Valentine"},
      {55 => "Experimenter"}
    ]
    assert_equal expected, tree.read_lines(file)
  end

  def test_tree_load_method_places_nodes
    tree = BinarySearchTree.new
    tree.load("./lib/movies.txt")
    assert tree.include?(15)
    assert tree.include?(36)
    refute tree.include?(101)
  end

  def test_tree_can_collect_nodes_at_depth
    depth_1 = [@tree.root]
    depth_2 = [@tree.root.left, @tree.root.right]
    assert_equal depth_1, @tree.nodes_at_depth(0)
    assert_equal depth_2, @tree.nodes_at_depth(1)
  end

  def test_tree_can_count_children
    tree = BinarySearchTree.new
    assert_equal "There is no tree...", tree.count_children
    assert_equal 3, @tree.count_children
    assert_equal 1, @tree.count_children(@tree.root.left)
  end

  def test_tree_can_count_all_nodes
    assert_equal 4, @tree.count_all_nodes
  end

  def test_tree_can_determine_health
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal [[98, 7, 100]], tree.health(0)
    assert_equal [[58, 6, 85]], tree.health(1)
    assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
  end

  def test_tree_can_count_leaves
    tree = BinarySearchTree.new
    assert_equal "There is no tree...", tree.leaves

    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")

    assert_equal 2, tree.leaves
  end

  def test_tree_determines_height
    assert_equal 2, @tree.height
  end
end
