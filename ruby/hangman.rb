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
    loop do
      input = gets.chomp
      break if input.match?(/[a-zA-Z]/) && input.length == 1 && !player.guessed_letters.any?(input)
    end
    input
  end

  def is_guess_correct?(word, guess)
    word.include?(guess)
  end

  def correct_guess(guess)
    player.guessed_letters.push(guess)
  end
end

class PlayerGameData
  attr_reader :word, :word_board, :guessed_letters

  include GameSetup

  def initialize
    @word = pick_word_from_list
    @word_board = create_word_board(@word)
    @guessed_letters = []
  end
end


get letter guess from user
add letter to guessed_letters and update word board with letter if match
continue until "0" command to save
