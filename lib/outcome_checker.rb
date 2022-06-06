class OutcomeChecker
  def win?(board)
    winning_combo?(board.lines)
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
