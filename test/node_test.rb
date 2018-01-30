require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/node.rb'

class TestNode < Minitest::Test

  def setup
    @root_node = Node.new(50, "root node", 0)
    @node_1 = Node.new(60, "node 1", 1)
  end

  def test_node_class_initializes
    assert_instance_of Node, @root_node
  end

  def test_node_takes_different_keys
    assert_equal 50, @root_node.key
    assert_equal 60, @node_1.key
  end

  def test_node_takes_different_values
    assert_equal "root node", @root_node.value
    assert_equal "node 1", @node_1.value
  end

  def test_node_takes_different_depths
    assert_equal 0, @root_node.depth
    assert_equal 1, @node_1.depth
  end

  def test_node_initializes_with_empty_branches
    assert_equal nil, @root_node.left
    assert_equal nil, @root_node.right
  end

end
