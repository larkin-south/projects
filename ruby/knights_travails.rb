class Travails
  attr_accessor :routes

  def initialize(beginning, endpoint)
    @start = beginning
    @destination = endpoint
    @routes = build_paths
  end

  def build_paths(coord = @start)
    return if coord == @destination

    @routes = Position.new(coord)

    build_paths(@routes.next_coords) until @routes.next_coords.include?(@destination)

    # coord
  end
end

class Position
  attr_reader :current_position, :next_coords, :next_coord0, :next_coord1, :next_coord2,
              :next_coord3, :next_coord4, :next_coord5, :next_coord6, :next_coord7

  def initialize(array)
    @current_position = array
    @next_coords = [array[0] + 1, array[1] + 2], [array[0] + 2, array[1] + 1], [array[0] + 2, array[1] - 1], [array[0] + 1, array[1] - 2],
                   [array[0] - 1, array[1] - 2], [array[0] - 2, array[1] - 1], [array[0] - 2, array[1] + 1], [array[0] - 1, array[1] + 2]
  end
end
travels = Travails.new([3,3], [4,5])
p travels.routes
