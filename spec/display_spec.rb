require 'display'

class TestBoardForEmptyBoard
  def get_space(row, column)
    index = (row * 3) + column
    index + 1
  end
end

describe 'Display' do
  context '#present' do
    it 'presents a formatted 3x3 board' do
      board = TestBoardForEmptyBoard.new
      display = Display.new

      expected_board_output = <<~BOARD
         1 | 2 | 3
        ---+---+---
         4 | 5 | 6
        ---+---+---
         7 | 8 | 9
      BOARD

      expect(display.present(board)).to eq(expected_board_output)
    end
  end
end
