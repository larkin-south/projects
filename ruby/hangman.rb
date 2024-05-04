require 'json'
require 'date'

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

  def save_game
    game_data = {
      word: @word,
      word_board: @word_board,
      guessed_letters: @guessed_letters,
      attempts: @attempts
    }

    Dir.mkdir('save_data') unless Dir.exist?('save_data')
    File.open('./save_data/hangman_save.json', 'w') do |file|
      file.puts game_data.to_json
    end
    exit
  end

  def load_game
    save_file = File.open('./save_data/hangman_save.json', 'r')
    save_file.each do |line|
      game_from_json(JSON.parse(line, { symbolize_names: true }))
    end
  end

  def game_from_json(game_data)
    @word = game_data[:word]
    @word_board = game_data[:word_board]
    @guessed_letters = game_data[:guessed_letters]
    @attempts = game_data[:attempts]

    play_game
  end
end

module Gameplay
  def player_guess
    puts "Enter a letter. Enter 'save' to save and exit or 'quit' to exit:"
    input = ''
    loop do
      input = gets.chomp.upcase
      if @guessed_letters.include?(input)
        puts 'You already guessed that letter. Try another.'
        redo
      end
      save_game if input == 'SAVE'
      exit if input == 'QUIT'
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

  def start_game
    puts '1: New Game | 2: Load Game'
    start = gets.chomp
    if start == '1'
      PlayerGameData.new.play_game
    elsif start == '2'
      PlayerGameData.new.load_game
    end
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
  include GameSetup
  include Gameplay

  def initialize
    @word = pick_word_from_list
    @word_board = create_word_board(@word)
    @guessed_letters = []
    @attempts = 0
  end
end

PlayerGameData.new.start_game
