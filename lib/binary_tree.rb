require 'pry'
require './lib/node.rb'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(key, value, depth = 0)
    if @root.nil?
      @root = Node.new(key, value)
      depth
    else
      @root.insert(key, value, depth += 1)
    end
  end

  def include?(key, node = @root)
    if key == node.key
      true
    elsif key > node.key
      if node.right.nil?
        false
      else
        include?(key, node.right)
      end
    elsif key < node.key
      if node.left.nil?
        false
      else
        include?(key, node.left)
      end
    end
  end

  def depth_of(key, node = @root, depth = 0)
    if key == node.key
      depth
    elsif key > node.key
      if node.right.nil?
        depth
      else
        depth_of(key, node.right, depth += 1)
      end
    elsif key < node.key
      if node.left.nil?
        depth
      else
        depth_of(key, node.left, depth += 1)
      end
    end
  end

end
