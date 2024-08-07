class Game
  def initialize
    @p1 = nil
    @p2 = nil
    @active_player = @p1
  end

  def play_game
    until game_over

      swap_players
    end

    puts "#{@active_player} wins!"
  end

  def player_input
    $stdin.gets.chomp.to_i
  end

  def swap_players
    @active_player = @active_player == @p1 ? @p2 : @p1
  end

  def game_over?
    # true
  end
end