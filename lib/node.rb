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
      "Duplicate key"
    elsif choose_direction(key).nil?
      create_node(key, value)
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

  def include?(key)
    if choose_direction(key) == "Duplicate"
      true
    elsif !choose_direction(key).nil?
      choose_direction(key).include?(key)
    else
      false
    end
  end

  def leaves(count = [])
    if @right.nil? && @left.nil?
      count << 1
    else
      [@left, @right].compact.map do |branch|
        branch.leaves(count)
      end
    end
    count.sum
  end
end
