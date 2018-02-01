require_relative 'test_helper.rb'
require './lib/node.rb'
require 'pry'

class TestNode < Minitest::Test

  def test_node_class_initializes
    new_node = Node.new(50, "root node")
    assert_instance_of Node, new_node
  end

  def test_node_takes_different_keys
    root_node = Node.new(50, "root node")
    node_1 = Node.new(60, "node 1")
    assert_equal 50, root_node.key
    assert_equal 60, node_1.key
  end

  def test_node_takes_different_values
    root_node = Node.new(50, "root node")
    node_1 = Node.new(60, "node 1")
    assert_equal "root node", root_node.value
    assert_equal "node 1", node_1.value
  end

  def test_node_initializes_with_empty_branches
    test_node = Node.new(90, "test")
    assert_nil test_node.left
    assert_nil test_node.right
  end

  def test_node_can_create_new_nodes
    root_node = Node.new(50, "root node")
    root_node.insert(51, "Right")
    root_node.insert(40, "Left")
    assert_instance_of Node, root_node.right
    assert_instance_of Node, root_node.left
  end

  def test_node_assigns_nodes_to_correct_branch
    root_node = Node.new(50, "root node")
    root_node.insert(51, "Right")
    root_node.insert(40, "Left")
    assert_equal 51, root_node.right.key
    assert_equal 40, root_node.left.key
  end

  def test_node_moves_down_when_branch_exists
    root_node = Node.new(50, "root node")
    values = {55 => "Right 1",
              40 => "Left 1",
              65 => "Right 2",
              30 => "Left 2"
              }
    values.each do |key, value|
      root_node.insert(key, value)
    end
    assert_equal 55, root_node.right.key
    assert_equal 40, root_node.left.key
    assert_equal 65, root_node.right.right.key
    assert_equal 30, root_node.left.left.key
  end

  def test_node_include?
    root_node = Node.new(50, "root node")
    root_node.insert(60, "node 1")
    assert root_node.include?(50)
    assert root_node.include?(60)
    refute root_node.include?(55)
  end

end
