class LinkedList 
  attr_accessor :head, :tail

  def initialize(value = nil)
    @head = @tail = Node.new(value)
  end

  def append(value = nil, next_node = nil)
    node = Node.new(value, next_node)
    node.next_node = nil
    @tail.next_node = node.value
    @tail = node
  end

  def prepend(value, next_node)
    node = Node.new(value, next_node)
    node.next_node = @head.value
    @head = node
  end

  def self.size
    node = @head
    count = 0
    until node.next_node.nil?
      count += 1
      node = node.next_node
    end
    count
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
    (count - 1).times do
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

list = LinkedList.new("test")
# list.append("another test")
p list.head.value
p list.head.next_node
p list.tail
# p list.tail.next_node
# list[0,1]
