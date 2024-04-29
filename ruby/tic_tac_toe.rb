# frozen-string-literal: true

require 'pry-byebug'
# Tracks player piece locations via array values
class PlayerActions
  attr_reader :locations

  def initialize(name)
    @name = name
    @locations = []
  end

  def place_piece
    puts @name.to_s.upcase
    row = nil
    col = nil
    until row.class == Integer && row.between?(1, 3)
      puts 'Enter row placement (1-3):'
      row = gets.chomp.to_i
    end
    until col.class == Integer && col.between?(1, 3)
      puts 'Enter column placement (1-3):'
      col = gets.chomp.to_i
    end
    @locations.push([row, col])

    if BoardUpdates.update_rows(@locations.last, @name) == 'retry'
      @locations.delete([row, col])
      'retry'
    else
      BoardUpdates.display_board
      BoardUpdates.player_win?(@locations)
    end
  end
end

# Updates board via locations in array per player
class BoardUpdates
  attr_accessor :board

  @board = {
    :row1 => [' ', ' ', ' '],
    :row2 => [' ', ' ', ' '],
    :row3 => [' ', ' ', ' ']
  }

  def self.update_rows(last_update, name)
    @row = "row#{last_update[0]}".to_sym
    @col = last_update[1].to_i - 1
    if @board[@row][@col] == ' '
      @board[@row][@col] = 'x' if name == 'player1'
      @board[@row][@col] = 'o' if name == 'player2'
    else
      BoardUpdates.display_board
      puts 'Position already taken. Choose another.'
      'retry'
    end
  end

  def self.display_board
    puts
    puts 'Current board:'
    puts '     1   2   3  '
    puts "1  | #{@board[:row1][0]} | #{@board[:row1][1]} | #{@board[:row1][2]} |"
    puts "2  | #{@board[:row2][0]} | #{@board[:row2][1]} | #{@board[:row2][2]} |"
    puts "3  | #{@board[:row3][0]} | #{@board[:row3][1]} | #{@board[:row3][2]} |"
    puts
  end

  def self.player_win?(updates)
    if BoardUpdates.row_win?(updates)
      true
    elsif BoardUpdates.col_win?(updates)
      true
    elsif BoardUpdates.cross_win?(updates)
      true
    else
      false
    end
  end

  def self.row_win?(updates)
    counter1 = 0
    counter2 = 0
    counter3 = 0
    updates.each do |row, _col|
      counter1 += 1 if row == 1
      counter2 += 1 if row == 2
      counter3 += 1 if row == 3
    end
    if counter1 == 3 || counter2 == 3 || counter3 == 3
      true
    else
      false
    end
  end

  def self.col_win?(updates)
    counter1 = 0
    counter2 = 0
    counter3 = 0
    updates.each do |_row, col|
      counter1 += 1 if col == 1
      counter2 += 1 if col == 2
      counter3 += 1 if col == 3
    end
    if counter1 == 3 || counter2 == 3 || counter3 == 3
      true
    else
      false
    end
  end

  def self.cross_win?(updates)
    check1 = [[1, 1], [2, 2], [3, 3]]
    check2 = [[1, 3], [2, 2], [3, 1]]
    if (check1 - updates).empty? || (check2 - updates).empty?
      true
    else
      false
    end
  end
end

# Game initiation
player1 = PlayerActions.new('player1')
player2 = PlayerActions.new('player2')

loop do
  p1_result = player1.place_piece
  while p1_result == 'retry'
    p1_result = player1.place_piece
  end
  if p1_result
    p 'Player1 wins!'
    break
  end
  p2_result = player2.place_piece
  while p2_result == 'retry'
    p2_result = player2.place_piece
  end
  if p2_result
    p 'Player2 wins!'
    break
  end
end
