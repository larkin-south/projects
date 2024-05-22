class Travails
  attr_accessor :routes

  def initialize(beginning, endpoint)
    @start = beginning
    @destination = endpoint
    @routes = build_paths
  end

  def build_paths(coord = @start, visits = [])
    return Position.new(coord) if coord == @destination

    # @routes = Position.new(coord)
    # # @routes.next_coords.delete(@start)

    # @routes.next_coords.each do |move|
    #   @routes.step_to = build_paths(move) until @routes.next_coords.include?(@destination)
    # end

    # @routes

    position = Position.new(coord)
    next_coords = [coord[0] + 1, coord[1] + 2], [coord[0] + 2, coord[1] + 1],
                  [coord[0] + 2, coord[1] - 1], [coord[0] + 1, coord[1] - 2],
                  [coord[0] - 1, coord[1] - 2], [coord[0] - 2, coord[1] - 1],
                  [coord[0] - 2, coord[1] + 1], [coord[0] - 1, coord[1] + 2]

    next_coords.filter! { |value| value.all? { |entry| entry.positive? && entry < 8 } }
    # coord_split = next_coords.slice!(0..(next_coords.length / 2))
    next_coords.each do |placement|
      visits.any? { |value| value == placement } ? next : visits << placement

      position.next_step = build_paths(placement, visits)
    end

    position
  end
end

class Position
  attr_accessor :current_position, :next_coords, :next_step, :step_to, :next_coord0, :next_coord1, :next_coord2,
              :next_coord3, :next_coord4, :next_coord5, :next_coord6, :next_coord7

  def initialize(array)
    @current_position = array
    @next_step = nil
    # @next_step = step_to
  end
end
travels = Travails.new([3,3], [4,5])
p travels.routes.each
