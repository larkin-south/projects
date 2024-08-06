#7w 6h
require '../lib/game.rb'

describe Game do
  subject(:game) { described_class.new }

  describe '#player_input' do
    context 'when player enters number from 1-7' do
      it 'number is returned' do
        expect(game).to receive(:gets)#.and_return(3)
        expect(game).to receive(:chomp).and_return(3)
        game.player_input
        # game.player_input.to eq(3)
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