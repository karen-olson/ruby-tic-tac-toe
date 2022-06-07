class OutcomeChecker
  def initialize(board:)
    @board = board
  end

  def win?
    winning_combo?(board.lines)
  end

  def draw?
    board.full? && !win?
  end

  private

  attr_reader :board

  def winning_combo?(lines)
    lines.any? { |line| all_equal?(line) }
  end

  def all_equal?(line)
    line.uniq.length == 1
  end
end
