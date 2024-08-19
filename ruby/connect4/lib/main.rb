require './game.rb'

puts 'Player 1, enter a name:'
player1 = gets.chomp
puts 'Player 2, enter a name:'
puts ' '
player2 = gets.chomp

Game.new(player1, player2)
