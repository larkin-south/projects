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

      root.value = delete_inorder(root.right)
      delete(root.value, root.right)
    elsif root.value < input
      root.right = delete(input, root.right)
    else
      root.left = delete(input, root.left)
    end

    root
  end

  def delete_inorder(root)
    root = root.left while root.left
    root.value
  end

  def find(input, root = @root)
    return if root.nil?

    if root.value == input
      root
    elsif root.value < input
      find(input, root.right)
    else
      find(input, root.left)
    end
  end

  def level_order
    return if @root.nil?

    queue = [@root]
    result = []
    until queue.empty?
      block_given? ? (result << queue[0].value if yield queue[0]) : result << queue[0].value
      queue << queue[0].left if queue[0].left
      queue << queue[0].right if queue[0].right
      queue.delete(queue[0])
    end

    result
  end

  def preorder(root = @root, &block)
    return [] if root.nil?

    result = []
    if block_given?
      result << root.value if yield root
    else
      result << root.value
    end

    result << preorder(root.left, &block)
    result << preorder(root.right, &block)

    result.flatten
  end

  def inorder(root = @root, &block)
    return [] if root.nil?

    result = []
    result << inorder(root.left, &block)

    if block_given?
      result << root.value if yield root
    else
      result << root.value
    end

    result << inorder(root.right, &block)
    result.flatten
  end

  def postorder(root = @root, &block)
    return [] if root.nil?

    result = []
    result << postorder(root.left, &block)
    result << postorder(root.right, &block)

    if block_given?
      result << root.value if yield root
    else
      result << root.value
    end

    result.flatten
  end

  def height(input = root.value, root = find(input))
    return -1 if root.nil?

    left_height = height(input, root.left)
    right_height = height(input, root.right)

    left_height > right_height ? left_height + 1 : right_height + 1
  end

  def depth(input, root = @root, depth = 0)
    return depth -= 1 if root.nil?
    return depth if root.value == input

    if root.value > input
      depth(input, root.left, depth + 1)
    else
      depth(input, root.right, depth + 1)
    end
  end

  def balanced?
    (height(root.value, root.left) - height(root.value, root.right)).between?(-1, 1)
  end

  def rebalance
    @root = build_tree(preorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

test = Tree.new(Array.new(15) { rand(1..100) })
p test.balanced?
p test.preorder
p test.inorder
p test.postorder

test.pretty_print

100.times { test.insert(rand(1..100)) }

test.pretty_print
p test.balanced?
p test.rebalance
p test.balanced?
p test.depth(12)
test.pretty_print
test
