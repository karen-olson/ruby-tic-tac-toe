require 'player'
require_relative '../lib/human_player'
require_relative '../lib/computer_player'

describe 'Player' do
  describe '#initialize' do
    it 'initializes subclasses with the correct options' do
      class TestConsoleForHumanPlayer
        def exists?
          true
        end
      end

      class TestBoardForComputerPlayer
        def exists?
          true
        end
      end

      console = TestConsoleForHumanPlayer.new
      board = TestBoardForComputerPlayer.new
      player_x = HumanPlayer.new(marker: 'X', console:)
      player_o = ComputerPlayer.new(marker: 'O', board:)

      expect(player_x.console).to exist
      expect(player_o.board).to exist
    end
  end

  describe '#marker' do
    it 'returns the correct marker' do
      class TestConsoleForPlayer
      end

      class TestBoardForPlayer
      end

      console = TestConsoleForPlayer.new
      board = TestBoardForPlayer.new
      player_x = HumanPlayer.new(marker: 'X', console:)
      player_o = ComputerPlayer.new(marker: 'O', board:)

      expect(player_x.marker).to eq('X')
      expect(player_o.marker).to eq('O')
    end
  end
end
