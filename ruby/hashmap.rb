class HashMap
  attr_accessor :storage

  def initialize
    @storage = {}
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end 

  def set(key, value)
    bucket = hash(key)

    if storage.key?(:"#{bucket}")
      storage[:"#{bucket}"].contains?(key) ? storage[:"#{bucket}"].replace(value) : storage[:"#{bucket}"].prepend(key, value)
    else
      storage[:"#{bucket}"] = LinkedList.new.prepend(key, value)
    end
  end

  def get(key)
    bucket = hash(key)

    if storage.key?(:"#{bucket}")
      storage[:"#{bucket}"].contains?(key) ? storage[:"#{bucket}"].find_value(key) : puts('Value does not exist.')
    else
      puts 'Value does not exist.'
    end
  end

  def has?(key)
    bucket = hash(key)
    return false unless storage.key?(:"#{bucket}")

    storage[:"#{bucket}"].contains?(key)
  end

  def remove(key)
    bucket = hash(key)
    return nil unless storage.key?(:"#{bucket}")

    index = storage[:"#{bucket}"].find_index(key)
    return index if index.nil?

    result = storage[:"#{bucket}"].delete_at(index)
    if result.nil?
      deleted = storage[:"#{bucket}"].value
      storage.delete(:"#{bucket}")
      deleted
    else
      result
    end
  end

  def length
    count = 0
    storage.each_value do |key|
      count += key.size
    end
    count
  end

  def clear
    @storage = {}
  end

  def keys
    array = []
    storage.each_value do |list|
      array << list.key_list
    end
    array.flatten
  end

  def values
    array = []
    storage.each_value do |list|
      array << list.value_list
    end
    array.flatten
  end

  def entries
    array = []
    storage.each_value do |list|
      array << list.list_array
    end
    array
  end
end

class LinkedList 
  attr_accessor :head

  def initialize
    @head = nil
  end

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

  def size
    node = self
    count = 1
    until node.next_node.nil?
      count += 1
      node = node.next_node
    end
    count
  end

  def contains?(key)
    node = self
    until node.next_node.nil?
      return true if node.key == key

      node = node.next_node
    end
    node.key == key
  end

  def replace(value)
    node = self
    node.value = value
  end

  def delete_at(index)
    node = self
    deleted_node = nil
    return deleted_node if index.zero? && node.next_node.nil?

    prev_node = nil
    if index.positive?
      (index - 1).times do
        node = node.next_node
        prev_node = node
      end
    end

    index.times do
      node = node.next_node
      deleted_node = node.value
    end

    (index + 1).times do
      node = node.next_node
    end

    prev_node.next_node = node
    deleted_node
  end

  def find_value(key)
    node = self
    until node.next_node.nil?
      return node.value if node.key == key

      node = node.next_node
    end
    node.key == key ? puts("#{node.value}") : puts('Value does not exist.')
  end

  def find_index(key)
    node = self
    count = 0
    return count if node.next_node.nil?

    until node.next_node.nil?
      return count if node.key == key

      count += 1
      node = node.next_node
    end
    nil
  end

  def key_list
    array = []
    node = self

    until node.next_node.nil?
      array << node.key
      node = node.next_node
    end
    array << node.key
    array
  end

  def value_list
    array = []
    node = self

    until node.next_node.nil?
      array << node.value
      node = node.next_node
    end
    array << node.value
    array
  end

  def list_array
    node = self
    array = []

    size.times do
      array << "#{node.key}, #{node.value}"
      node = node.next_node unless node.next_node.nil?
    end

    array
  end
end

class Node < LinkedList
  attr_accessor :key, :value, :next_node

  def initialize(key = nil, value = nil, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end

hashmap = HashMap.new
hashmap.set('larkin', 'cyber')
hashmap.set('dan', 'cyber')
hashmap.set('larkin', 'developer')
hashmap.set('jonathon', 'cyber')
hashmap.set('jamie', 'cyber')
hashmap.set('jacob', 'sec')
hashmap.set('joanne', 'sec')
hashmap.set('debbie', 'tesa')
hashmap.set('victoria', 'tesa')
hashmap.set('randy', 'iso')
hashmap.remove('dan')

hashmap
