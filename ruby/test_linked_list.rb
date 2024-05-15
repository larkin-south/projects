class Node
  attr_accessor :value, :next_node

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end

class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    if @head
      tail.next_node = Node.new(value)
    else
      @head = Node.new(value)
    end
  end

  def prepend(value)
    new_node = Node.new(value)
    new_node.next_node = @head
    @head = new_node
  end

  def head
    @head
  end

  def tail
    node = @head
    return node unless node.next_node

    return node unless node.next_node while (node = node.next_node)
  end

  def at(index)
    node = @head
    return node if index == 0
    index.times do |i|
      node = node.next_node
    end
  end

  def size
    count = 0
    node = @head

    while node
      count += 1
      node = node.next_node
    end

    return count
  end

  def contains?(value)
    node = @head

    return false unless node

    while node
      return true if node.value == value
      node = node.next_node
    end

    false
  end

  def to_s
    node = @head

    while node

      if node == tail
        print "( #{node.value} ) -> nil"
        puts " "
      else
        print "( #{node.value} ) -> "
      end

      node = node.next_node
    end

  end

end

linked_list = LinkedList.new
linked_list.prepend(0)
num = 1
6.times do
  linked_list.append(num)
  num+=1
end
linked_list.to_s
puts " "
puts "Linked List attributes: "
puts " "
puts "head: #{linked_list.head}"
puts "tail: #{linked_list.tail}"
puts " "
puts "size: #{linked_list.size}"
puts " "
puts "contains? ex: 6? #{linked_list.contains?(6)}"
puts "contains? ex: 7? #{linked_list.contains?(7)}"
puts " "
puts "at index 2: #{linked_list.at(2)}"
puts "at index 5: #{linked_list.at(5)}"
puts " "
puts "you can add a value to the end of the list linked_list.append(7): #{linked_list.append(7)}"
puts " "
puts "You can print out the list by typing linked_list.to_s #{linked_list.to_s}"
