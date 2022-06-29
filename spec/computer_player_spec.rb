require 'computer_player'

class TestBoardForComputerPlayer
    def available?(space)
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
        }[space]
    end
end

describe 'Computer Player' do
    describe '#marker' do
        it 'returns the correct marker' do
            board = TestBoardForComputerPlayer.new
            computer_player = ComputerPlayer.new(marker:'X', board:)

            marker = computer_player.marker

            expect(marker).to eq('X')
        end
    end

    describe '#select_space' do
        it 'returns the first available space' do
            board = TestBoardForComputerPlayer.new
            computer_player = ComputerPlayer.new(marker:'X', board:)

            space = computer_player.select_space

            expect(space).to eq(2)
        end
    end
end