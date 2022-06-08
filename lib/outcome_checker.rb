class OutcomeChecker
  def initialize(board:)
    @board = board
  end

  def win?
    winning_combo?(board.combinations)
  end

  def draw?
    full_board?(board.combinations) && !win?
  end

  private

  attr_reader :board

  def winning_combo?(combinations)
    combinations.any? { |combination| all_equal?(combination) }
  end

  def all_equal?(combination)
    combination.uniq.length == 1
  end

  def full_board?(combinations)
    combinations.none? { |combination| combination.any?(Integer) }
  end
end
