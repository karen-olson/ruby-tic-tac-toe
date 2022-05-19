require 'display'

class TestBoardForEmptyBoard
  def values
    (1..9).to_a
  end

  def get_space(row, column)
    index = (row * 3) + column
    values[index]
  end
end

describe 'Display' do
  context '#present' do
    it 'presents a formatted 3x3 board' do
      board = TestBoardForEmptyBoard.new
      values = board.values
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
