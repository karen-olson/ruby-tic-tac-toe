require 'display'

class TestBoardManagerForEmptyBoard
  def board_values
    (1..9).to_a
  end
end

describe 'Display' do
  context '#present' do
    it 'presents a formatted 3x3 board' do
      board_manager = TestBoardManagerForEmptyBoard.new
      board_values = board_manager.board_values
      display = Display.new

      expected_board_output = <<~BOARD
         1 | 2 | 3
        ---+---+---
         4 | 5 | 6
        ---+---+---
         7 | 8 | 9
      BOARD

      expect(display.present(board_values)).to eq(expected_board_output)
    end
  end
end
