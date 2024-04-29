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
    puts "#{@name.upcase}"
    row = nil
    unless row.instance_of?(Integer) && row < 4 && row.positive?
      puts 'Enter row placement (1-3):'
      row = gets.chomp
    end
    puts 'Enter column placement (1-3):'
    col = gets.chomp
    @locations.push([row, col])

    BoardUpdates.update_rows(@locations, @name)
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

  def self.update_rows(updates, name)
    updates.each do |item|
      @row = "row#{item[0]}".to_sym
      @col = item[1].to_i - 1
      @board[@row][@col] = 'x' if name == 'player1'
      @board[@row][@col] = 'o' if name == 'player2'
    end
    BoardUpdates.display_board
    BoardUpdates.player_win?(updates)
  end

  def self.display_board
    puts
    puts 'Current board:'
    puts "| #{@board[:row1][0]} | #{@board[:row1][1]} | #{@board[:row1][2]} |"
    puts "| #{@board[:row2][0]} | #{@board[:row2][1]} | #{@board[:row2][2]} |"
    puts "| #{@board[:row3][0]} | #{@board[:row3][1]} | #{@board[:row3][2]} |"
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
      counter1 += 1 if row.to_i == 1
      counter2 += 1 if row.to_i == 2
      counter3 += 1 if row.to_i == 3
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
      counter1 += 1 if col.to_i == 1
      counter2 += 1 if col.to_i == 2
      counter3 += 1 if col.to_i == 3
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
    if !(check1 - updates) == check1 || !(check2 - updates) == check2
      true
    else
      false
    end
  end
end

player1 = PlayerActions.new('player1')
player2 = PlayerActions.new('player2')

loop do
  if player1.place_piece
    p 'Player1 wins!'
    break
  elsif player2.place_piece
    p 'Player2 wins!'
    break
  end
end
