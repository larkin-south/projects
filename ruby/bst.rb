require './merge_sort'

class Node
  def initialize(midpoint)
    @data = midpoint
    @left = nil
    @right = nil
  end
end

class Tree
  def initialize(array)
    @array = array
    @root = nil
  end

  def build_tree
    return if @array.nil?

    sorted_array = merge_sort(@array).uniq

    midpoint = sorted_array.length / 2

    root = Node.new(sorted_array[midpoint])

    left_side = sorted_array.slice(0, midpoint + 1).length
    right_side = sorted_array.slice(midpoint + 1..).length
  end
end

p test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]).build_tree
