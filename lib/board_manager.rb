class BoardManager
  attr_accessor :board_values

  def initialize
    @board_values = (1..9).to_a
  end

  def mark_space(token, space)
    board_values[space - 1] = token
  end
end
