class Travails
  attr_accessor :routes

  def initialize(beginning, endpoint)
    @start = beginning
    @destination = endpoint
    @routes = build_paths
  end

  def build_paths(coord = @start, step_to = nil)
    return if coord == @destination

    @routes = Position.new(coord)
    # @routes.next_coords.delete(@start)

    @routes.next_coords.each do |move|
      @routes.step_to = build_paths(move) until @routes.next_coords.include?(@destination)
    end

    @routes
  end
end

class Position
  attr_reader :current_position, :next_coords, :step_to, :next_coord0, :next_coord1, :next_coord2,
              :next_coord3, :next_coord4, :next_coord5, :next_coord6, :next_coord7

  def initialize(array, step_to = nil)
    @current_position = array
    @next_coords = [array[0] + 1, array[1] + 2], [array[0] + 2, array[1] + 1],
                   [array[0] + 2, array[1] - 1], [array[0] + 1, array[1] - 2],
                   [array[0] - 1, array[1] - 2], [array[0] - 2, array[1] - 1],
                   [array[0] - 2, array[1] + 1], [array[0] - 1, array[1] + 2]
    # @next_step = step_to
  end
end
travels = Travails.new([3,3], [4,5])
p travels.routes
