
class Node
  attr_reader :key, :value, :depth, :left, :right

  def initialize(key, value, depth)
    @key = key
    @value = value
    @depth = depth
    @left = nil
    @right = nil
  end

end
