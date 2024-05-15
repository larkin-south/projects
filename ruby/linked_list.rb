class LinkedList 
  attr_reader :head

  def initialize()
    @head = nil
  end

  def append(value)
    if @head
      node = Node.new(value)
      node.next_node = @head
      @head.next_node = nil
      @head = node
  end

  def prepend(value, next_node)
    node = Node.new(value, next_node)
    node.next_node = @head.value
    @head = node
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

  # def head
  #   @head
  # end

  def tail
    node = @head
    return node unless node.next_node

    return node unless node.next_node while (node = node.next_node)
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
    count = self.size
    count.times do
      node = node.next_node
    end
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
      count += 1
      return count if node.value == value

      node = node.next_node
    end
  end

  # def to_s
    
  # end
end

class Node 
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

list = LinkedList.new()
list.append("test")
p list.head
# p list.head.next_node
# p list.tail
# p list.size
# p list.tail.next_node
# list[0,1]
