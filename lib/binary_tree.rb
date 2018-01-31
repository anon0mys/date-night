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
    if !node.left.nil?
      sort(node.left, sorted_array)
    end
    sorted_array.push({node.key => "#{node.value}"})
    if !node.right.nil?
      sort(node.right, sorted_array)
    end
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
      array = line.chomp.split(", ")
      score = array.first.to_i
      title = array[1..-1].join(", ")
      {score => title}
    end
  end

end
