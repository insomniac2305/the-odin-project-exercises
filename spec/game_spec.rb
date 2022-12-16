require_relative '..\lib\Game.rb'
require_relative '..\lib\Player.rb'

describe Game do  
  let(:player1) { instance_double(Player, name: 'P1', symbol: 'X') }
  let(:player2) { instance_double(Player, name: 'P2', symbol: 'O') }
  let(:playing_field) { instance_double(GridField) }
  subject(:game_init) { described_class.new(player1, player2, playing_field) }

  describe '#playRound' do
    context 'when player selects empty cell' do
      let(:row) { 1 }
      let(:column) { 1 }
      before do
        allow(game_init).to receive(:selectionToRow).and_return(row)
        allow(game_init).to receive(:selectionToColumn).and_return(column)
        allow(playing_field).to receive(:cellIsEmpty?).and_return(true)
        allow(playing_field).to receive(:setCell)
      end

      it 'sets the cell to the player symbol' do
        selection = 5    
        expect(playing_field).to receive(:setCell).with(row, column, player1.symbol)
        game_init.playRound(player1, selection)        
      end

      it 'returns true' do
        selection = 5
        result = game_init.playRound(player1, selection)
        expect(result).to be true
      end
    end

    context 'when player selects populated cell' do
      let(:row) { 1 }
      let(:column) { 1 }
      before do
        allow(game_init).to receive(:selectionToRow).and_return(row)
        allow(game_init).to receive(:selectionToColumn).and_return(column)
        allow(playing_field).to receive(:cellIsEmpty?).and_return(false)
        allow(game_init).to receive(:print)
      end

      it 'returns false' do
        selection = 5
        result = game_init.playRound(player1, 5)
        expect(result).to be false
      end
    end

    context 'when player selection is out of bounds' do
      before do
        allow(game_init).to receive(:print)
      end
      it 'returns false' do
        selection = 100
        result = game_init.playRound(player1, selection)
        expect(result).to be false
      end
    end
  end

end