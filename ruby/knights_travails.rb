class Travails
  attr_accessor :routes
  attr_reader :destination

  def initialize(beginning, endpoint)
    @start = beginning
    @destination = endpoint
    @routes = build_paths
  end

  def build_paths(coord = @start, visits = Set.new)
    return Position.new(coord) if coord == @destination
    return if coord.nil?

    routes = Position.new(coord)
    visits.add(coord)
    next_coords = calculate_coordinates(coord)

    next_coords.filter! { |value| value.all? { |entry| entry.positive? && entry < 8 } }
    next_coords.map! do |value|
      if value == @destination
        visits.add(value)
        value = nil
      end
      value
    end
    next_coords.each_with_index do |placement, index|
      next if visits.include?(@destination) || placement.nil?

      next_routes = build_paths(placement, visits.clone) #unless placement.nil?

      routes.instance_variable_set("@next_coord#{index}", next_routes)
    end

    routes
  end

  def calculate_coordinates(coord)
    [[coord[0] + 1, coord[1] + 2], [coord[0] + 2, coord[1] + 1],
    [coord[0] + 2, coord[1] - 1], [coord[0] + 1, coord[1] - 2],
    [coord[0] - 1, coord[1] - 2], [coord[0] - 2, coord[1] - 1],
    [coord[0] - 2, coord[1] + 1], [coord[0] - 1, coord[1] + 2]]
  end

  # def pretty_print(node = @routes, prefix = '', is_left = true, index = 0)
  #   while index < 8
  #     # pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  #     puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.current_position}"
  #     pretty_print(node.next_coord[index], "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.next_coord[index]
  #     index += 1
  #   end
  # end

  # def level_order(index = 0)
  #   return if @routes.nil?

  #   queue = [@routes]
  #   result = []
  #   while index < 8
  #     until queue.empty?
  #       block_given? ? (result << queue[index].current_position if yield queue[index]) : result << queue[index].current_position
  #       # queue << queue[0].left if queue[0].left
  #       queue << queue[index].next_coord0 # if queue[0].right
  #       queue.delete(queue[index])
  #     end
  #     index += 1
  #   end

  #   result
  # end
end

class Position
  attr_accessor :current_position, :next_coords, :next_step, :step_to, :next_coord0, :next_coord1, :next_coord2,
                :next_coord3, :next_coord4, :next_coord5, :next_coord6, :next_coord7

  def initialize(array)
    @current_position = array
  end
end
travels = Travails.new([3, 3], [4, 5])
p travels.routes
# p travels.level_order { |item| item == @destination }
# p travels.level_order { |value| value == travels.destination}
# p travels.routes.next_coord0
# p travels.routes.next_coord1

# p travels.routes.next_coord2

# p travels.routes.next_coord3

