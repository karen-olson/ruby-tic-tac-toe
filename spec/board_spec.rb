require 'board'

describe 'Board' do
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

  context '.full?' do
    it 'returns true when the board is full' do
      board = Board.new

      board.values = %w[X O O X X O X X O]

      expect(board.full?).to eq(true)
    end

    it 'returns false when the board is not full' do
      board = Board.new

      board.values = ['X', 1, 'O', 'X', 'X', 'O', 'X', 'X', 'O']

      expect(board.full?).to eq(false)
    end
  end
end
