require 'pry'
require './lib/node.rb'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(key, value)
    if @root.nil?
      @root = Node.new(key, value)
      @root.depth_of(key)
    else
      @root.insert(key, value)
    end
  end

  def depth_of(key, depth = 0)
    if key == @root.key
      depth
    else
      @root.depth_of(key)
    end
  end

  def include?(key, node = @root)
    if key == node.key
      true
    else
      @root.include?(key)
    end
  end

  def max(node = @root)
    if node.right.nil?
      {"#{node.value}"=>node.key}
    else
      max(node.right)
    end
  end

  def min(node = @root)
    if node.left.nil?
      {"#{node.value}"=>node.key}
    else
      min(node.left)
    end
  end

  def sort(node = @root, sorted_array = [])
    sort(node.left, sorted_array) if !node.left.nil?
    sorted_array.push({node.key => "#{node.value}"})
    sort(node.right, sorted_array) if !node.right.nil?
    sorted_array
  end

  def load(filename)
    file = File.open(filename, 'r')
    movies_inserted = 0
    read_lines(file).each do |movie_hash|
      if !include?(movie_hash.keys.first)
        insert(movie_hash.keys[0], movie_hash.values[0])
        movies_inserted += 1
      end
    end
    movies_inserted
  end

  def read_lines(file)
    file.readlines.map do |line|
      transform_line(line)
    end
  end

  def transform_line(line)
    line_array = line.chomp.split(", ")
    score = line_array.first.to_i
    title = line_array[1..-1].join(", ")
    {score => title}
  end
end
