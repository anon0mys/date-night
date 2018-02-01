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

  def test_binary_tree_wont_take_duplicates
    skip
    tree = BinarySearchTree.new
    tree.insert(60, "root node")
    assert_equal "Duplicate key", tree.insert(60, "test node")
  end

  def test_tree_returns_depth_when_node_inserts
    tree = BinarySearchTree.new
    assert_equal 0, tree.insert(60, "root node")
    assert_equal 1, tree.insert(65, "level 1")
    assert_equal 2, tree.insert(70, "level 2")
  end

  def test_binary_tree_include?
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
end
