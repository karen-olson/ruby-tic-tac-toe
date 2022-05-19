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
end
