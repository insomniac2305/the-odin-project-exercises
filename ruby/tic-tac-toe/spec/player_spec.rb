require_relative '..\lib\Player.rb'

describe Player do

  describe '#==' do
    context 'when a player is compared' do
      subject(:player1) { described_class.new('name', 'x') }
      subject(:player1b) { described_class.new('name', 'x') }
      subject(:player2) { described_class.new('another', 'o') }
      
      it 'equals another player when name and symbol match' do            
        expect(player1).to eq(player1b)
      end
      
      it 'does not equal another player when name or symbol does not match' do
        expect(player1).not_to eq(player2)
      end
    end
  end
  
  describe '#create_new_player' do
    context 'when player is created' do
      let(:new_player_equal) { described_class.new('player1', 'x') }
      
      before do
        player_name = 'player1'
        player_symbol = 'x'
        allow(described_class).to receive(:gets).and_return(player_name, player_symbol)
        allow(described_class).to receive(:print)
      end    
      
      it 'returns a player with given name and symbol' do
        new_player1 = described_class.create_new_player(1)
        expect(new_player1).to eq(new_player_equal)
      end
    end
  end
end