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
      depth_of(key)
    else
      @root.insert(key, value)
      depth_of(key)
    end
  end

  def depth_of(key, node = @root, depth = 0)
    if node.choose_direction(key) == "Duplicate"
      depth
    elsif !node.choose_direction(key).nil?
      depth_of(key, node.choose_direction(key), depth += 1)
    else
      "Key does not exist"
    end
  end

  def include?(key, node = @root)
    if @root.nil?
      false
    elsif key == node.key
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
    file = open_file(filename)
    movies_inserted = 0
    read_lines(file).each do |movie_hash|
      if !include?(movie_hash.keys[0])
        insert(movie_hash.keys[0], movie_hash.values[0])
        movies_inserted += 1
      end
    end
    movies_inserted
  end

  def open_file(filename)
    if File.exist?(filename)
      File.open(filename, 'r')
    else
      "File does not exist"
    end
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
