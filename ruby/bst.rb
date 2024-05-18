require './merge_sort'

class Node
  attr_accessor :value, :left, :right

  def initialize(midpoint)
    @value = midpoint
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @data = merge_sort(array.uniq)
    @root = build_tree(@data)
  end

  def build_tree(array)
    return if array.empty?

    midpoint = array.length / 2

    root = Node.new(array[midpoint])

    root.left = build_tree(array[...midpoint])
    root.right = build_tree(array[midpoint + 1..])

    root
  end

  def insert(input, root = @root)
    return Node.new(input) if root.nil?

    if root.value == input
      root
    elsif root.value < input
      root.right = insert(input, root.right)
    else
      root.left = insert(input, root.left)
    end

    root
  end

  def delete(input, root = @root)
    return root if root.nil?

    if root.value == input
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end
    elsif root.value < input
      root.right = delete(input, root.right)
    else
      root.left = delete(input, root.left)
    end

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
 
end

test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# test.insert(10)
# test.delete(7)
# test.delete(1)
# p test.build_tree(@data)
test.pretty_print
