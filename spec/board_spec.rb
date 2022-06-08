require 'board'

describe 'Board' do
  context 'given a row and column number (from 0 - 2)' do
    it '#get_space returns the correct value for the given coordinates' do
      board = Board.new
      board.values = [1, 2, 3, 4, 5, 6, 7, 8, 9]

      expect(board.get_space(0, 0)).to eq(1)
      expect(board.get_space(2, 2)).to eq(9)
    end
  end

  context '#mark_space' do
    it 'places an X in the selected space on the board' do
      board = Board.new
      token = 'X'
      space = 1

      board.mark_space(token, space)

      expected_values = ['X', 2, 3, 4, 5, 6, 7, 8, 9]

      expect(board.values).to eq(expected_values)
    end
  end

  context '#available?' do
    it 'returns true when the space is available' do
      board = Board.new

      board.values = ['X', 2, 3, 'O', 5, 6, 'X', 8, 9]

      expect(board.available?(6)).to eq(true)
    end

    it 'returns false when the space is not available' do
      board = Board.new

      board.values = ['X', 2, 3, 'O', 5, 6, 'X', 8, 9]

      expect(board.available?(7)).to eq(false)
    end
  end

  describe '#combinations' do
    context 'given an empty board' do
      it 'returns the correct values' do
        board = Board.new

        board.values = [
          1, 2, 3,
          4, 5, 6,
          7, 8, 9
        ]

        expected_combinations = [
          [1, 2, 3], [4, 5, 6], [7, 8, 9],
          [1, 4, 7], [2, 5, 8], [3, 6, 9],
          [1, 5, 9], [3, 5, 7]
        ]

        expect(board.combinations).to eq(expected_combinations)
      end
    end

    context 'given a full board' do
      it 'returns the correct values' do
        board = Board.new

        board.values = [
          'O', 'O', 'X',
          'X', 'X', 'O',
          'O', 'X', 'O'
        ]

        expected_combinations = [
          ['O', 'O', 'X'], ['X', 'X', 'O'], ['O', 'X', 'O'],
          ['O', 'X', 'O'], ['O', 'X', 'X'], ['X', 'O', 'O'],
          ['O', 'X', 'O'], ['X', 'X', 'O']
        ]

        expect(board.combinations).to eq(expected_combinations)
      end
    end
  end
end
