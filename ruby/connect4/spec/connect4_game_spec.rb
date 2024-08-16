#7w 6h
require '../lib/game.rb'
require '../lib/piece.rb'

describe Game do
  subject(:game) { described_class.new('player1', 'player2') }
  let(:piece) { instance_double(Piece) }

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

  describe '#game_over?' do

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

  describe '#place_piece' do
    context 'when #player_input returns 3 for player1' do
      # it "adds '1' to cage[2]" do
      #   cage = game.instance_variable_get(:@cage)
      #   # row = cage[2].find_index
      #   expect { game.place_piece(3) }.to change { cage[2] }.by(1)
      # end
    end

    context 'when #player_input returns 5 for player2' do
      before do
        game.swap_players
      end
      # it "adds '2' to cage[4]" do
      #   cage = game.instance_variable_get(:@cage)
      #   expect { game.place_piece(5) }.to change { cage[4].last }.to eq(2)
      # end
    end
  end

  describe 'vertical_win?' do
    context 'when a player has 4 consecutive pieces in the same column' do
      before do
        game.instance_variable_set(:@cage, [[], [], [1, 2, 1, 1, 1, 1], [], [], [], []])
      end
      it 'returns true' do
        expect(game.vertical_win?).to be true
      end
    end

    context 'when a player does not have 4 consecutive pieces in the same column' do
      before do
        game.instance_variable_set(:@cage, [[], [], [1, 2, 1, 1], [], [], [], []])
      end
      it 'returns false' do
        expect(game.vertical_win?).to be false
      end
    end
  end

  describe 'horizontal_win?' do
    context 'when a player has 4 consecutive pieces in the same row' do
      before do
        game.instance_variable_set(:@cage, [[1, 1], [2, 1], [2, 1], [1, 1], [1], [1], []])
      end
      it 'returns true' do
        expect(game.horizontal_win?).to be true
      end
    end

    context 'when a player does not have 4 consecutive pieces in the same row' do
      before do
        game.instance_variable_set(:@cage, [[1, 2], [2, 1], [2, 1], [1, 1], [1], [1], []])
      end
      it 'returns false' do
        expect(game.horizontal_win?).to be false
      end
    end
  end

  describe 'left_diagonal_win?' do
    context 'when a player has 4 consecutive pieces in diagonal order from the bottom-left of the cage' do
      before do
        game.instance_variable_set(:@cage, [[1, 2], [2, 1], [2, 1, 1], [1, 1, 1, 1], [2, 2, 1], [1, 2, 2], [2, 2, 1]])
      end
      it 'returns true' do
        expect(game.left_diagonal_win?).to be true
      end
    end
    context 'when no pieces are a diagonal match from the bottom-left' do
      before do
        game.instance_variable_set(:@cage, [[1, 2], [2, 1], [2, 1, 2], [1, 1, 1, 1], [2, 2, 1], [1, 2, 2], [1, 2, 1]])
      end
      it 'returns false' do
        expect(game.left_diagonal_win?).to be false
      end
    end
  end

  describe 'right_diagonal_win?' do
    context 'when a player has 4 consecutive pieces in diagonal order from the bottom-right of the cage' do
      before do
        p2 = instance_variable_get(:@p2)
        game.instance_variable_set(:@active_player, p2)
        game.instance_variable_set(:@cage, [[1, 2], [2, 1], [2, 1], [1, 1, 1, 2], [2, 2, 2], [1, 2, 2], [2, 2, 1]])
      end
      it 'returns true' do
        expect(game.right_diagonal_win?).to be true
      end
    end

    context 'when no pieces are a diagonal match from the bottom-right' do
      before do
        p2 = instance_variable_get(:@p2)
        game.instance_variable_set(:@active_player, p2)
        game.instance_variable_set(:@cage, [[1, 2], [2, 1], [2, 1], [1, 1, 1, 2], [2, 2, 1], [1, 2, 2], [2, 2, 1]])
      end
      it 'returns false' do
        expect(game.right_diagonal_win?).to be false
      end
    end
  end
end





#check game win, player input, place piece, next player