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
    if choose_direction(key) == "Duplicate"
      "Duplicate or invalid key"
    elsif choose_direction(key).nil?
      create_node(key, value)
      depth_of(key)
    else
      choose_direction(key).insert(key, value)
    end
  end

  def choose_direction(key)
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
    if choose_direction(key) == "Duplicate"
      depth
    elsif !choose_direction(key).nil?
      choose_direction(key).depth_of(key, depth += 1)
    else
      "Key does not exist"
    end
  end

  def include?(key)
    if choose_direction(key) == "Duplicate"
      true
    elsif !choose_direction(key).nil?
      choose_direction(key).include?(key)
    else
      false
    end
  end
end
