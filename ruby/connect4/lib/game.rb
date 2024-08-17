class Game
  def initialize(p1 = nil, p2 = nil)
    @p1 = p1
    @p2 = p2
    @active_player = @p1
    @cage = Array.new(7) { Array.new(6, ' ') }#[[], [], [], [], [], [], []]
  end

  def play_game
    swap_players until game_over?

    puts "#{@active_player} wins!"
  end

  def player_input
    $stdin.gets.chomp.to_i
  end

  def place_piece(column)
    row = @cage[column - 1].find_index { |item| item == ' ' }
    @cage[column - 1][row] = (@active_player == @p1 ? 1 : 2)
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
    
  end
end
