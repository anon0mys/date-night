require_relative 'test_helper.rb'
require './lib/node.rb'
require './lib/binary_tree.rb'

class TestBinarySearchTree < Minitest::Test

  def test_binary_tree_initializes
    tree = BinarySearchTree.new
    assert_instance_of BinarySearchTree, tree
  end

  def test_binary_tree_creates_first_node_at_root
    tree = BinarySearchTree.new
    tree.insert(61, "Bill and Ted's Excellent Adventure")
    assert_equal 61, tree.root.key
  end

  def test_binary_tree_takes_multiple_nodes
    tree = BinarySearchTree.new
    tree.insert(61, "Bill and Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal 61, tree.root.key
    assert_equal 16, tree.root.left.key
    assert_equal 92, tree.root.right.key
    assert_equal 50, tree.root.left.right.key
  end

end
