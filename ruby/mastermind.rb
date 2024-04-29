# game starts with computer randomly assinging colors to array
# player guesses assortment of colors in an order
# computer compares input to its own array
# if any colors match, then check for order matching as well
# each correct item and position gets black peg from computer
# right color, wrong position gets white peg
# no pegs returned if no color in guess is used in code
require 'pry-byebug'
# player guesses list of colors into array
# compare to compter array, any matching values AND index returns black
# matching value ONLY returns white
# when arrays match, win

# class GameEnvironment

class Codemaker
  @@color_table = {
    :'1' => 'red',
    :'2' => 'yellow',
    :'3' => 'green',
    :'4' => 'blue',
    :'5' => 'black',
    :'6' => 'white'
  }

  def initialize
    @color_options = %w[red yellow green blue black white]
    @code = @color_options.sample(4)
  end

  def show_colors
    @code
  end

  def black_pegs(guess)
    count = 0
    guess.each_with_index do |value, index|
      count += 1 if @code[index] == value
    end
    count
  end

  def white_pegs(guess)
    guess.reduce(0) do |acc, item|
      if @code.any?(item)
        acc += 1
      else
        acc
      end
    end
  end

  def convert_guess_to_colors(guess)
    guess.map { |value| @@color_table[value.to_sym] }
  end

  def win_condition?(guess)
    @code.intersection(guess).count == 4
  end
end

class Codebreaker
  def new_guess
    puts 'Enter 4 numbers matching with the color options shown:'
    puts 'Red - 1 | Yellow - 2 | Green - 3 | Blue - 4 | Black - 5 | White - 6'
    puts
    @guess = []

    while @guess.count != 4
      puts "Position #{@guess.count + 1}:"
      @entry = gets.chomp.to_i
      @guess.push(@entry.to_s) if @entry.between?(1, 6) && @entry.instance_of?(Integer)
    end

    @guess
  end
end

codemaker = Codemaker.new
codebreaker = Codebreaker.new
1..12.each do
  guess = codebreaker.new_guess
  converted_guess = codemaker.convert_guess_to_colors(guess)
  codemaker.win_condition?
  num_white_pegs = codemaker.white_pegs(converted_guess)
  num_black_pegs = codemaker.black_pegs(converted_guess)
end
