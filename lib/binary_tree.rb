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

  def nodes_at_depth(node = @root, node_array = [], depth)
    if depth == depth_of(node.key)
      node_array.push(node)
    else
      [node.left, node.right].compact.map do |branch|
        nodes_at_depth(branch, node_array, depth)
      end
    end
    node_array.flatten
  end

  def count_children(node = @root, count = [])
    if @root.nil?
      "There is no tree..."
    else
      [node.left, node.right].compact.each do |branch|
        count << 1
        count_children(branch, count)
      end
      count.sum
    end
  end

  def count_all_nodes
    count_children(@root) + 1
  end

  def health_percent(children)
    percent = (children.to_f/count_all_nodes) * 100
    percent.to_i
  end

  def health(depth)
    health_array = []
    nodes_at_depth(depth).each do |node|
      children = count_children(node) + 1
      node_health = [
        node.key,
        children,
        health_percent(children)
      ]
      health_array.push(node_health)
    end
    health_array
  end

  def leaves
    if @root.nil?
      "There is no tree..."
    else
      @root.leaves
    end
  end

  def height(depth = 0)
    if @root.nil?
      "There is no tree..."
    elsif branches_below?(depth)
      height(depth += 1)
    else
      depth
    end
  end

  def branches_below?(depth)
    tree_level = nodes_at_depth(depth).map do |node|
      node.left.nil? && node.right.nil?
    end
    tree_level.include?(false)
  end

end
