# require_relative '../test_lib_markfla/main.rb'
require_relative '../test_lib_markfla/game.rb'
require_relative '../test_lib_markfla/board.rb'

describe Game do
  # describe '#game_loop' do
  #   subject(:game) { described_class.new('test1', 'test2') }
  #   # allow(game_loop).to receive(:gets).and_return(true)
  #   # allow(game_loop).to receive(:puts)

  #   context '@game_over is true' do
  #     # allow(game).to receive(:gets).and_return(true)
  #     before do
  #       allow(game).to receive(:chomp).twice
  #     end


  #     it 'stops loop and puts message' do
  #       expect(game).to receive(:chomp)
  #       expect(game).to receive(:gets).and_return(true)
  #       game.game_loop
  #     end
  #   end
  # end
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
  end
end
