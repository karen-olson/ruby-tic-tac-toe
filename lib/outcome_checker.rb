class OutcomeChecker
  def win?(board)
    winning_combo?(board.rows) || winning_combo?(board.columns) || winning_combo?(board.diagonals)
  end

  def draw?(board)
    board.full? && !win?(board)
  end

  private

  def winning_combo?(lines)
    line_statuses = lines.map { |line| all_equal?(line) }
    line_statuses.include?(true)
  end

  def all_equal?(line)
    line.uniq.length == 1
  end
end
