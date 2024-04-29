# game starts with computer randomly assinging colors to array
# player guesses assortment of colors in an order
# computer compares input to its own array
# if any colors match, then check for order matching as well
# each correct item and position gets black peg from computer
# right color, wrong position gets white peg
# no pegs returned if no color in guess is used in code

# player guesses list of colors into array
# compare to compter array, any matching values AND index returns black
# matching value ONLY returns white
# when arrays match, win

# class GameEnvironment
#   attr_reader :color_options

#   def self.choose_colors
#     @color_options = %w[red yellow blue green black white]
#     @color_options.sample(4)
#   end
# end

class Codemaker

  def choose_colors
    @color_options = %w[red yellow green blue black white]
    @color_options.sample(4)
  end

end

class Codebreaker

  def new_guess
    puts 'Enter 4 numbers matching with the color options shown:'
    puts 'Red - 1 | Yellow - 2 | Green - 3 | Blue - 4 | Black - 5 | White - 6'
    guess = []
    while guess.count != 4
      unless guess.between?(1, 6) && guess.instance_of?(Integer) && guess.count == 4
        guess.push(gets.chomp)
      end
    end
  end

end

codemaker = Codemaker.new
codebreaker = Codebreaker.new
p codemaker.choose_colors
