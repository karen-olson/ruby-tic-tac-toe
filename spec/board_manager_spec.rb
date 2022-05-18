require 'board_manager'

describe 'BoardManager' do
  context '#mark_space' do
    it 'places an X in the selected space on the board' do
      board_manager = BoardManager.new
      token = 'X'
      space = 1

      board_manager.mark_space(token, space)

      expected_board_values = ['X', 2, 3, 4, 5, 6, 7, 8, 9]

      expect(board_manager.board_values).to eq(expected_board_values)
    end
  end
end
