class LinkedList 
  attr_accessor :head, :tail

  def initialize
    @head = nil
  end

  def append(value)
    @tail.next_node = value
    value.next_node = nil
  end

  def prepend(value)
    value.next_node = @head
    @head = value
  end

  def size
    node = @head
    count = 0
    until node.next_node.nil?
      count += 1
      node = node.next_node
    end
    count
  end


end

class Node 
  attr_accessor :value, :next_node

  def initialize
    @value = nil
    @next_node = nil
  end
end
