require 'computer_player'

describe 'Computer Player' do
  describe 'select_space' do
    it 'returns the first available board space' do
      class TestBoardForComputerPlayer
        def available?(input)
          {
            1 => false,
            2 => true,
            3 => true,
            4 => false,
            5 => false,
            6 => false,
            7 => false,
            8 => false,
            9 => false
          }[input]
        end
      end

      board = TestBoardForComputerPlayer.new
      player = ComputerPlayer.new(marker: 'X', board:)

      expect(player.select_space).to eq('2')
    end
  end
end
