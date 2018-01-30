require 'pry'

class Node
  attr_reader :key, :value, :left, :right

  def initialize(key, value)
    @key = key
    @value = value
    @left = nil
    @right = nil
  end

  def insert(key, value, depth = 1)
    if key > @key
      if @right == nil
        @right = Node.new(key, value)
        depth
      else
        @right.insert(key, value, depth += 1)
      end
    elsif key < @key
      if @left == nil
        @left = Node.new(key, value)
        depth
      else
        @left.insert(key, value, depth += 1)
      end
    else
      puts "Duplicate or invalid key"
    end
  end

end
