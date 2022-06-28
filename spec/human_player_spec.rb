require 'human_player'

describe 'Human Player' do
  describe 'select_space' do
    it 'returns input from the human player' do
      class TestConsoleForHumanPlayer
        def gets_input
          '1'
        end
      end

      console = TestConsoleForHumanPlayer.new
      player = HumanPlayer.new(marker: 'X', console:)

      expect(player.select_space).to eq('1')
    end
  end
end
