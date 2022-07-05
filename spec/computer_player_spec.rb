require 'computer_player'
require 'pry'

class EmptyBoard
  def available?(space)
    {
      1 => true,
      2 => true,
      3 => true,
      4 => true,
      5 => true,
      6 => true,
      7 => true,
      8 => true,
      9 => true
    }[space]
  end
end

class SpacesOneThroughFiveAvailable
  def available?(space)
    {
      1 => true,
      2 => true,
      3 => true,
      4 => true,
      5 => true,
      6 => false,
      7 => false,
      8 => false,
      9 => false
    }[space]
  end
end

class PredictableNumberGenerator
  def initialize
    @numbers = [4, 7, 6, 5, 9, 2, 8, 1, 3]
  end

  def random_number
    @numbers.shift
  end
end

describe 'Computer Player' do
  describe '#marker' do
    it 'returns the correct marker' do
      empty = EmptyBoard.new
      pseudo_random_number_generator = PredictableNumberGenerator.new
      computer_player = ComputerPlayer.new(marker: 'X', board: empty,
                                           random_number_generator: pseudo_random_number_generator)

      marker = computer_player.marker

      expect(marker).to eq('X')
    end
  end

  describe '#select_space' do
    context 'when the board is empty' do
      it 'returns a predictable random space' do
        empty = EmptyBoard.new
        pseudo_random_number_generator = PredictableNumberGenerator.new
        computer_player = ComputerPlayer.new(marker: 'X', board: empty,
                                             random_number_generator: pseudo_random_number_generator)

        selections = []

        9.times do
          selections << computer_player.select_space
        end

        expect(selections).to eq([4, 7, 6, 5, 9, 2, 8, 1, 3])
      end
    end

    context 'when the board is not empty' do
      it 'returns a predictable random available space' do
        one_thru_five_available = SpacesOneThroughFiveAvailable.new
        pseudo_random_number_generator = PredictableNumberGenerator.new
        computer_player = ComputerPlayer.new(marker: 'X', board: one_thru_five_available,
                                             random_number_generator: pseudo_random_number_generator)

        selections = []

        5.times do
          selections << computer_player.select_space
        end

        expect(selections).to eq([4, 5, 2, 1, 3])
      end
    end
  end
end
