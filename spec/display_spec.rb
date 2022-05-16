require 'display'

describe 'Display' do
  context '#present' do
    it 'presents a formatted 3x3 board' do
      display = Display.new

      board = <<~BOARD
         1 | 2 | 3
        ---+---+---
         4 | 5 | 6
        ---+---+---
         7 | 8 | 9
      BOARD

      expect(display.present).to eq(board)
    end
  end
end
