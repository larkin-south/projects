class Travails
  attr_accessor :routes
  attr_reader :destination

  def initialize(origin, destination)
    @start = origin
    @end = destination
    @routes = build_paths
  end

  def build_paths(current = @start, visits = Set.new)
    return Knight.new(current) if current == @destination

    routes = Knight.new(current)
    calculate_coordinates(routes, current)

    routes
  end

  def calculate_coordinates(routes, current)
    routes.option0 = Knight.new([current[0] + 1, current[1] + 2])
    routes.option1 = Knight.new([current[0] + 2, current[1] + 1])
    routes.option2 = Knight.new([current[0] + 2, current[1] - 1])
    routes.option3 = Knight.new([current[0] + 1, current[1] - 2])
    routes.option4 = Knight.new([current[0] - 1, current[1] - 2])
    routes.option5 = Knight.new([current[0] - 2, current[1] - 1])
    routes.option6 = Knight.new([current[0] - 2, current[1] + 1])
    routes.option7 = Knight.new([current[0] - 1, current[1] + 2])
  end
end

class Knight
  attr_accessor :current_position, :option0, :option1, :option2,
                :option3, :option4, :option5, :option6, :option7,
                :visits

  def initialize(array)
    @current_position = array
  end
end
travels = Travails.new([3, 3], [4, 5])
p travels.routes
