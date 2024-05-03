module GameSetup
  def pick_word_from_list
    word_list = File.read('google-10000-english-no-swears.txt')

    word_list = word_list.lines.filter do |word|
      word.length.between?(5, 12)
    end
    word_list.sample
  end

  def create_word_board(word)
    Array.new(word.length, '_')
  end
end

module Gameplay
  def get_player_guess
    puts 'Enter a letter:'
    loop do
      input = gets.chomp
      break if input.match?(/[a-zA-Z]/) && input.length == 1 && !player.guessed_letters.any?(input)
    end
    input
  end

  def update_attempts
    player.attempts += 1
  end

  def is_guess_correct?(word, guess)
    word.include?(guess)
  end

  def correct_guess(guess)
    player.guessed_letters.push(guess)

    # return False if player.word.split('').&(guess.split('')).count < 1

    letter_index = []
    player.word.split('').each_with_index do |letter, index|
      letter_index.push(index) if letter == guess
    end

    letter_index.each do |index|
      player.word_board[index] = guess
    end
  end

  # def wrong_guess(guess)
    
  # end

  def win?
    player.word == player.word_board
  end
end

class PlayerGameData
  attr_accessor :attempts
  attr_reader :word, :word_board, :guessed_letters, :guess_limit

  include GameSetup
  include Gameplay

  def initialize
    @word = pick_word_from_list
    @word_board = create_word_board(@word)
    @guessed_letters = []
    @guess_limit = 15
    @attempts = 0
  end
end

player = PlayerGameData.new
player_guess = player.get_player_guess
player.update_attempts
player.is_guess_correct? ? correct_guess(player_guess) : player.guessed_letters.push(guess)
if player.win?
  puts "You win!"
end

get letter guess from user
add letter to guessed_letters and update word board with letter if match
continue until "0" command to save
