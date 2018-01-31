require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'simplecov'
require './lib/node.rb'
require 'pry'
SimpleCov.start

class TestNode < Minitest::Test

  def setup
    @root_node = Node.new(50, "root node")
    @node_1 = Node.new(60, "node 1")
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

  def test_node_initializes_with_empty_branches
    test_node = Node.new(90, "test")
    assert_nil test_node.left
    assert_nil test_node.right
  end

  def test_node_can_create_new_nodes
    @root_node.insert(51, "Right")
    @root_node.insert(40, "Left")
    assert_instance_of Node, @root_node.right
    assert_instance_of Node, @root_node.left
  end

  def test_node_assigns_nodes_to_correct_branch
    @root_node.insert(51, "Right")
    @root_node.insert(40, "Left")
    assert_equal 51, @root_node.right.key
    assert_equal 40, @root_node.left.key
  end

  def test_node_moves_down_when_branch_exists
    values = {55 => "Right 1",
              40 => "Left 1",
              65 => "Right 2",
              30 => "Left 2"
              }
    values.each do |key, value|
      @root_node.insert(key, value)
    end
    assert_equal 55, @root_node.right.key
    assert_equal 40, @root_node.left.key
    assert_equal 65, @root_node.right.right.key
    assert_equal 30, @root_node.left.left.key
  end

end
