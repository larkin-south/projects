#7w 6h
require '../lib/game.rb'
require '../lib/cage.rb'

describe Game do
  subject(:game) { described_class.new }
  let(:cage) { instance_double(Cage) }

  describe '#play_game' do
    context 'when game is over' do
      before do
        game.instance_variable_set(:@active_player, :@p1)
      end

      it 'breaks loop, puts endgame text' do
        expect(game).to receive(:game_over?).and_return(true)
        expect(game).to receive(:puts).with("#{game.instance_variable_get(:@active_player)} wins!").once
        game.play_game
      end
    end
  end

  describe '#game_over' do

  end

  describe '#swap_players' do
    context 'when player 1 round is over' do
      before do
        game.instance_variable_set(:@p1, 'player1')
        game.instance_variable_set(:@p2, 'player2')
        game.instance_variable_set(:@active_player, game.instance_variable_get(:@p1))
      end

      it 'player 1 swaps to player 2' do
        expect { game.swap_players }.to change { game.instance_variable_get(:@active_player) }
          .from(game.instance_variable_get(:@p1))
          .to(game.instance_variable_get(:@p2))
      end
    end

    context 'when player 2 round is over' do
      before do
        game.instance_variable_set(:@p1, 'player1')
        game.instance_variable_set(:@p2, 'player2')
        game.instance_variable_set(:@active_player, game.instance_variable_get(:@p2))
      end

      it 'player 2 swaps to player 1' do
        expect { game.swap_players }.to change { game.instance_variable_get(:@active_player) }
          .from(game.instance_variable_get(:@p2))
          .to(game.instance_variable_get(:@p1))
      end
    end
  end

  describe '#player_input' do
    context 'when player enters number from 1-7' do
      before do
        $stdin = StringIO.new('3')
      end

      after do
        $stdin = STDIN
      end

      it 'number is returned' do
        expect(game.player_input).to eq(3)
      end
    end

    # context 'when player enters number <1 or >7' do
    #   it 'loops until correct input' do
    #     expect(game).to receive(:gets).and_return(0, 7)
    #   end
    # end
  end
end





#check game win, player input, place piece, next player