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
    puts "#{@name.upcase} (x)"
    puts 'Enter row placement:'
    row = gets.chomp
    puts 'Enter column placement:'
    col = gets.chomp
    @locations.push([row, col])

    BoardUpdates.update_rows(@locations, @name)
  end

  # private
end

# Updates board via locations in array per player
class BoardUpdates
  attr_accessor :board

  @board = {
    :row1 => ['-', '-', '-'],
    :row2 => [' ', ' ', ' '],
    :row3 => [' ', ' ', ' ']
  }

  def self.update_rows(updates, name)
    updates.each do |item|
      puts item
      @row = item[0]
      @col = item[1]
      # binding.pry
      if name == 'player1'
        @board[":row#{@row}"][@col] = 'x'
      else
        @board[":row#{@row}"][@col] = 'o'
      end
    end
    puts @board[:row1], @board[:row2], @board[:row3]
  end

  def player_win?
  end
end

player1 = PlayerActions.new('player1')
player2 = PlayerActions.new('player2')

loop do
  player1.place_piece
  player2.place_piece
  return if BoardUpdates.player_win?
end

# track player locations in array
# pass locations to boardUpdates
# updates "board" string with array values from each object
# classes: playeractions for locations, boardupdates to pull locations, store/update strings
