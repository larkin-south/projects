class LinkedList 
  attr_accessor :head

  def initialize
    @head = nil
  end

  def append(value)
    node = Node.new(value)
    node.next_node = @head if head
    @head = node
  end

  def prepend(value)
    node = Node.new(value)
    if head
      current = @head
      current = current.next_node while current.next_node
      current.next_node = node
    else
      @head = node
    end
  end

  def size
    node = @head
    count = 1
    until node.next_node.nil?
      count += 1
      node = node.next_node
    end
    count
  end

  def tail
    node = @head
    return node unless node.next_node

    node = node.next_node while node.next_node
    node
  end

  def at(index)
    node = @head
    index.times do
      node = node.next_node
    end
    node
  end

  def pop
    node = @head
    node = node.next_node unless node.next_node.nil?
    node.next_node = nil
  end

  def contains?(value)
    node = @head
    until node.next_node.nil?
      return true if node.value == value

      node = node.next_node
    end
    false
  end

  def find(value)
    node = @head
    count = 0
    until node.next_node.nil?
      return count if node.value == value

      count += 1
      node = node.next_node
    end
    puts 'Value does not exist.'
  end

  def to_s
    node = @head
    string = ''

    size.times do
      string += "( #{node.value} ) -> "
      node = node.next_node
    end

    puts string[0...(string.length - 4)]
  end
end

class Node 
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

list = LinkedList.new
list.prepend('test1')
list.prepend('test2')
list.prepend('test3')
list.append('test0')
puts list.size
puts list.head
puts list.tail
puts list.at(1)
puts list.contains?('test1')
puts list.contains?('nothing')
puts list.find('test2')
list.to_s
