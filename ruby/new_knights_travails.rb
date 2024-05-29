class Travails
  attr_accessor :routes
  attr_reader :end

  def initialize(beginning, ending)
    @origin = beginning
    @destination = ending
    @routes = build_paths
  end

  def build_paths(current = @origin, last = nil, visits = Set.new)
    if current == @destination
      knight = Knight.new(current)
      # knight.previous = last
      return knight
    end

    routes = Knight.new(current)
    # routes.previous = last
    visits.add(current)
    paths = calculate_coordinates(current)

    8.times do |i|
      if paths[i].any? { |value| value.negative? || value >= 8 } || visits.include?(paths[i])
        routes.instance_variable_set("@option#{i}", nil)
        next
      end

      routes.instance_variable_set("@option#{i}", build_paths(paths[i], routes, visits))
    end

    routes
  end

  def calculate_coordinates(current)
    # routes.option0 = Knight.new([current[0] + 1, current[1] + 2])
    # routes.option1 = Knight.new([current[0] + 2, current[1] + 1])
    # routes.option2 = Knight.new([current[0] + 2, current[1] - 1])
    # routes.option3 = Knight.new([current[0] + 1, current[1] - 2])
    # routes.option4 = Knight.new([current[0] - 1, current[1] - 2])
    # routes.option5 = Knight.new([current[0] - 2, current[1] - 1])
    # routes.option6 = Knight.new([current[0] - 2, current[1] + 1])
    # routes.option7 = Knight.new([current[0] - 1, current[1] + 2])

    [
      [current[0] + 1, current[1] + 2], [current[0] + 2, current[1] + 1],
      [current[0] + 2, current[1] - 1], [current[0] + 1, current[1] - 2],
      [current[0] - 1, current[1] - 2], [current[0] - 2, current[1] - 1],
      [current[0] - 2, current[1] + 1], [current[0] - 1, current[1] + 2]
    ]
  end

  def shortest_path(paths = [])
    8.times do |i|
      current_path = routes.instance_variable_get("@option#{i}")
      next if current_path.nil?

      if current_path.current_position == @destination
        paths << current_path
        return paths
      end
    end

    paths
  end
end

class Knight
  attr_accessor :current_position, :option0, :option1, :option2,
                :option3, :option4, :option5, :option6, :option7,
                :visits#, :previous

  def initialize(array)
    @current_position = array
  end
end
travels = Travails.new([3, 3], [4, 5])
p travels.routes
p travels.routes.instance_variables
# test = travels.shortest_path
# p test
# p test.previous
