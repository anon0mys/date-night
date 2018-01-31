require 'pry'

class Node
  attr_reader :key, :value, :left, :right

  def initialize(key, value)
    @key = key
    @value = value
    @left = nil
    @right = nil
  end

  def insert(key, value)
    if traverse(key) == "Duplicate"
      "Duplicate or invalid key"
    elsif traverse(key).nil?
      create_node(key, value)
      depth_of(key)
    else
      traverse(key).insert(key, value)
    end
  end

  def traverse(key)
    if key == @key
      "Duplicate"
    elsif key > @key
      @right
    elsif key < @key
      @left
    end
  end

  def create_node(key, value)
    if key > @key
      @right = Node.new(key, value)
    elsif key < @key
      @left = Node.new(key, value)
    end
  end

  def depth_of(key, depth = 0)
    # if traverse(key) == "Duplicate"
    #   depth
    # elsif traverse(key).nil?
    # end
  end


end
