require 'pry-byebug'

module GameSetup
  def pick_word_from_list
    word_list = File.read('google-10000-english-no-swears.txt')

    word_list = word_list.lines.filter do |word|
      word.length.between?(5, 12)
    end
    word_list.sample.upcase.chomp
  end

  def create_word_board(word)
    Array.new(word.length, '_')
  end
end

module Gameplay
  def player_guess
    puts 'Enter a letter:'
    input = ''
    loop do
      input = gets.chomp.upcase
      if @guessed_letters.include?(input)
        puts 'You already guessed that letter. Try another.'
        redo
      end
      break if input.match?(/[a-zA-Z]/) && input.length == 1
    end
    puts
    input.upcase
  end

  def update_attempts
    @attempts += 1
  end

  def guess_correct?(word, guess)
    word.include?(guess)
  end

  def correct_guess(guess)
    @guessed_letters.push(guess)

    letter_index = []
    @word.split('').each_with_index do |letter, index|
      letter_index.push(index) if letter == guess
    end

    letter_index.each do |index|
      @word_board[index] = guess
    end
  end

  def show_game_status
    puts @word_board.join(' ')
    puts
    puts "Attempts remaining: #{15 - @attempts}"
    puts "Guessed letters: #{@guessed_letters}"
    puts
  end

  def win?
    return unless @word == @word_board.join('')

    show_game_status
    puts
    puts "You win!\nCorrect word: #{@word}"
    puts
    true
  end

  def lose?
    return unless @attempts == 15

    puts "You ran out of guesses.\nCorrect word: #{@word}"
    puts
    true
  end

  def play_game
    show_game_status
    loop do
      new_guess = player_guess
      if guess_correct?(@word, new_guess)
        correct_guess(new_guess)
      else
        @guessed_letters.push(new_guess)
        update_attempts
      end

      break if win?
      break if lose?

      show_game_status
    end
  end
end

class PlayerGameData
  attr_accessor :attempts
  attr_reader :word, :word_board, :guessed_letters

  include GameSetup
  include Gameplay

  def initialize
    @word = pick_word_from_list
    @word_board = create_word_board(@word)
    @guessed_letters = []
    @attempts = 0
  end
end

PlayerGameData.new.play_game

# continue until "0" command to save
