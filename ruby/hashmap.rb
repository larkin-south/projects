class HashMap
  def init
    storage = {}
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end 

  def set(key, value)
    hash = hash(key)

    if storage.key?(hash)
      storage[:"#{hash}"].contains?(key) ? replace(key, value) : storage[:"#{hash}"].prepend(key, value)
    else
      storage[:"#{hash}"] = LinkedList.new.prepend(key, value)
    end
  end
end
#if no key, create head with value
#if key, then update, or create tail if no match
class LinkedList 
  attr_accessor :head

  def initialize
    @head = nil
  end

  # def append(value)
  #   node = Node.new(value)
  #   node.next_node = @head if head
  #   @head = node
  # end

  def prepend(key, value)
    node = Node.new(key, value)
    if head
      current = @head
      current = current.next_node while current.next_node
      current.next_node = node
    else
      @head = node
    end
  end

  # def size
  #   node = @head
  #   count = 1
  #   until node.next_node.nil?
  #     count += 1
  #     node = node.next_node
  #   end
  #   count
  # end

  # def tail
  #   node = @head
  #   return node unless node.next_node

  #   node = node.next_node while node.next_node
  #   node
  # end

  # def at(index)
  #   node = @head
  #   index.times do
  #     node = node.next_node
  #   end
  #   node
  # end

  # def pop
  #   node = @head
  #   node = node.next_node unless node.next_node.nil?
  #   node.next_node = nil
  # end

  def contains?(key)
    node = @head
    until node.next_node.nil?
      return true if node.key == key

      node = node.next_node
    end
    false
  end

  def replace(key, value)
    node = @head
    node = node.next_node until node.next_node == key
    node.value = value
  end

  # def find(value)
  #   node = @head
  #   count = 0
  #   until node.next_node.nil?
  #     return count if node.value == value

  #     count += 1
  #     node = node.next_node
  #   end
  #   puts 'Value does not exist.'
  # end

  # def to_s
  #   node = @head
  #   string = ''

  #   size.times do
  #     string += "( #{node.value} ) -> "
  #     node = node.next_node
  #   end

  #   puts string[0...(string.length - 4)]
  # end
end

class Node 
  attr_accessor :key, :value, :next_node

  def initialize(key = nil, value = nil, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end

hashmap = HashMap.new
