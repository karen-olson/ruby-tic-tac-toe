class Display
  def initialize(console:)
    @console = console
  end

  def present(board)
    console.output(board_display(board))
  end

  private

  attr_reader :console

  def board_display(board)
    <<~BOARD
       #{board.get_space(0, 0)} | #{board.get_space(0, 1)} | #{board.get_space(0, 2)}
      ---+---+---
       #{board.get_space(1, 0)} | #{board.get_space(1, 1)} | #{board.get_space(1, 2)}
      ---+---+---
       #{board.get_space(2, 0)} | #{board.get_space(2, 1)} | #{board.get_space(2, 2)}
    BOARD
  end
end
