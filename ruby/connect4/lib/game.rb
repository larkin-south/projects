class Game
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @active_player = @p1
    @cage = Array.new(7) { Array.new(6, ' ') }
    play_game
  end

  def play_game
    loop do
      place_piece
      break if game_over?

      swap_players
    end

    puts "#{@active_player} wins!"
  end

  def player_input
    puts "#{@active_player}, enter a column number 1-7:"
    $stdin.gets.chomp.to_i
  end

  def place_piece
    column = 0
    column = player_input until column.between?(1, 7)
    row = @cage[column - 1].find_index { |item| item == ' ' }
    @cage[column - 1][row] = (@active_player == @p1 ? 1 : 2)
  end

  def swap_players
    @active_player = @active_player == @p1 ? @p2 : @p1
  end

  def game_over?
    vertical_win? || horizontal_win? || left_diagonal_win? || right_diagonal_win? ? true : false
  end

  def vertical_win?
    regex = @active_player == @p1 ? /1{4}/ : /2{4}/
    @cage.any? { |column| column.join.match?(regex) }
  end

  def horizontal_win?
    regex = @active_player == @p1 ? /1{4}/ : /2{4}/
    6.times do |row|
      result = collect_horizontal_pieces(row)
      return true if result.join.match?(regex)
    end
    false
  end

  def collect_horizontal_pieces(row)
    pieces = []
    column = 0
    pieces << @cage[column][row]
    until column > 5
      column += 1
      break unless @cage[column][row] == ' ' || !@cage[column][row].nil?

      pieces << @cage[column][row]
    end
    pieces
  end

  def left_diagonal_win?
    regex = @active_player == @p1 ? /1{4}/ : /2{4}/
    3.times do |row|
      result = nil
      4.times do |column|
        result = left_collect_diagonal_pieces(row, column)
        return true if result.join.match?(regex)
      end
    end
    false
  end

  def left_collect_diagonal_pieces(row, column)
    pieces = []
    pieces << @cage[column][row]
    until column > 6
      column += 1
      row += 1
      break unless @cage[column][row] == ' ' || !@cage[column][row].nil?

      pieces << @cage[column][row]
    end
    pieces
  end

  def right_diagonal_win?
    regex = @active_player == @p1 ? /1{4}/ : /2{4}/
    3.times do |row|
      result = nil
      6.downto(3) do |column|
        result = right_collect_diagonal_pieces(row, column)
        return true if result.join.match?(regex)
      end
    end
    false
  end

  def right_collect_diagonal_pieces(row, column)
    pieces = []
    pieces << @cage[column][row]
    until column < 3
      column -= 1
      row += 1
      break unless @cage[column][row] == ' ' || !@cage[column][row].nil?

      pieces << @cage[column][row]
    end
    pieces
  end

  def draw?
    @cage.none? { |column| column.any? { |row| row == ' ' } }
  end
end
