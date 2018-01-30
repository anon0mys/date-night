require 'pry'
require './lib/node.rb'

class BinarySearchTree
  attr_reader :root, :height

  def initialize
    @root = nil
  end

  def insert(key, value, depth = 0)
    if @root == nil
      @root = Node.new(key, value)
      depth
    else
      @root.insert(key, value, depth += 1)
    end
  end

end
