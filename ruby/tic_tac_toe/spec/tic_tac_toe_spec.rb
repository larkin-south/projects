# require_relative '../test_lib_markfla/main.rb'
require_relative '../test_lib_markfla/game.rb'
require_relative '../test_lib_markfla/board.rb'

describe Game do
  describe '#game_loop' do
    subject(:game) { described_class.new('test1', 'test2') }
    let(:board) { instance_double(Board.new) }

    describe '#make_move' do
      context 'when move is valid' do
        before do
          position = double
          expect(game).to receive(:gets).and_return(position)
          expect(position).to receive(:chomp).and_return(2)
          expect(position).to receive(:to_i)
          allow(board).to receive(:valid_move?).and_return(true)
        end
        it 'will call #update_position' do
          # game.stub(:gets).and_return(2)
          # game.stub(:chomp).and_return(2)
          expect(board).to receive(:valid_move?).with(2).and_return(true)
          expect(game).to receive(:update_position).with(2, 'X')
          game.make_move
        end
      end
    end
  end

  describe '#swap_player' do
    context 'when players swap' do
      it 'changes p1 to p2' do
        
      end
    end
  end
end

describe Board do
  subject(:board) { described_class.new }

  describe '#valid_move?' do
    context 'move to 2 is valid' do
      before do
        allow(board).to receive(:gets).and_return('-')
      end
      it 'returns true' do
        expect(board.valid_move?(2)).to eq(true)
      end
    end

    context 'number outside 0-8 not valid' do
      before do
        allow(board).to receive(:gets).and_return('-')
      end
      it 'returns true' do
        expect(board.valid_move?(9)).to eq(false)
      end
    end
  end
end
