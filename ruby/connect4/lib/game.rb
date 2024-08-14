class Game
  def initialize(p1 = nil, p2 = nil)
    @p1 = p1
    @p2 = p2
    @active_player = @p1
    @cage = [[], [], [], [], [], [], []]
  end

  def play_game
    swap_players until game_over?

    puts "#{@active_player} wins!"
  end

  def player_input
    $stdin.gets.chomp.to_i
  end

  def place_piece(column)
    @cage[column - 1] << (@active_player == @p1 ? 1 : 2)
  end

  def swap_players
    @active_player = @active_player == @p1 ? @p2 : @p1
  end

  def game_over?
    # true
  end

  def vertical_win?
    regex = @active_player == @p1 ? /1{4}/ : /2{4}/
    @cage.any? { |column| column.join.match?(regex) }
  end

  def horizontal_win?
    regex = @active_player == @p1 ? /1{4}/ : /2{4}/
    6.times do |row|
      result = []
      7.times do |column|
        result << @cage[column][row]
      end

      return true if result.join.match?(regex)
    end
    false
  end
end
