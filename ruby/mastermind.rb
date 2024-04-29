class Codemaker
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
    @color_table = {
      '1': 'red',
      '2': 'yellow',
      '3': 'green',
      '4': 'blue',
      '5': 'black',
      '6': 'white'
    }

    guess.map { |value| @color_table[value.to_sym] }
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

(1..12).each do |round_number|
  puts "Round #{round_number}"
  guess = codebreaker.new_guess
  converted_guess = codemaker.convert_guess_to_colors(guess)
  puts
  puts "1: #{converted_guess[0]} | 2: #{converted_guess[1]} | 3: #{converted_guess[2]} | 4: #{converted_guess[3]}"

  if codemaker.win_condition?(converted_guess)
    puts 'You win!'
    puts "Secret code: #{codemaker.show_colors}"
    break
  end

  num_white_pegs = codemaker.white_pegs(converted_guess)
  num_black_pegs = codemaker.black_pegs(converted_guess)

  puts
  puts "Black pegs returned: #{num_black_pegs}"
  puts "White pegs returned: #{num_white_pegs}"
  puts

  if round_number == 12
    puts 'You lose!'
    puts "Secret code: #{codemaker.show_colors}"
  end
end
