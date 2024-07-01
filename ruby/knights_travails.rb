class Travails
  attr_accessor :routes
  attr_reader :end

  def initialize(beginning, ending)
    @origin = beginning
    @destination = ending
    @routes = build_paths
  end

  def build_paths(current = @origin, parent = nil)
    if current == @destination
      knight = Knight.new(current)
      knight.previous = parent
      return knight
    end

    knight = Knight.new(current)
    knight.previous = parent
    queue = [knight]
    until queue.empty?
      current_node = queue.shift
      next if current_node.current_position.any? { |value| value.negative? || value >= 8 }
      return current_node if current_node.current_position == @destination

      paths = calculate_coordinates(current_node.current_position)
      paths.each do |coord|
        new_path = Knight.new(coord)
        new_path.previous = current_node
        queue << new_path
      end
    end
    nil
  end

  def calculate_coordinates(current)
    [
      [current[0] + 1, current[1] + 2], [current[0] + 2, current[1] + 1],
      [current[0] + 2, current[1] - 1], [current[0] + 1, current[1] - 2],
      [current[0] - 1, current[1] - 2], [current[0] - 2, current[1] - 1],
      [current[0] - 2, current[1] + 1], [current[0] - 1, current[1] + 2]
    ]
  end

  def show_route
    array = []
    until @routes.nil?
      array << @routes.current_position
      @routes = @routes.previous
    end

    p "The path from #{@origin} to #{@destination} is:"
    array.reverse
  end
end

class Knight
  attr_accessor :current_position, :option0, :option1, :option2,
                :option3, :option4, :option5, :option6, :option7,
                :previous

  def initialize(array)
    @current_position = array
  end
end
travels = Travails.new([0, 0], [7, 7])
p travels.show_route
