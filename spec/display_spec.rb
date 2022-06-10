require 'display'

class TestBoardForEmptyBoard
  def get_space(row, column)
    {
      [0, 0] => 1,
      [0, 1] => 2,
      [0, 2] => 3,
      [1, 0] => 4,
      [1, 1] => 5,
      [1, 2] => 6,
      [2, 0] => 7,
      [2, 1] => 8,
      [2, 2] => 9
    }[[row, column]]
  end
end

class TestConsoleForDisplay
  attr_accessor :messages

  def initialize
    @messages = []
  end

  def output(message)
    messages << message
  end
end

describe 'Display' do
  context '#present' do
    it 'presents a formatted 3x3 board' do
      console = TestConsole.new
      board = TestBoardForEmptyBoard.new
      display = Display.new(console:)

      expected_board_output = <<~BOARD
         1 | 2 | 3
        ---+---+---
         4 | 5 | 6
        ---+---+---
         7 | 8 | 9
      BOARD

      display.present(board)

      expect(console.messages).to eq([expected_board_output])
    end
  end

  context '#message' do
    it 'prints the message to the console' do
      console = TestConsole.new
      message = 'My message'
      display = Display.new(console:)

      display.message(message)

      expect(console.messages).to eq([message])
    end
  end
end
