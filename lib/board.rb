class Board
  attr_accessor :values

  def initialize
    @values = (1..9).to_a
  end

  def get_space(row, column)
    index = (row * 3) + column
    values[index]
  end

  def mark_space(token, space)
    values[space - 1] = token
  end

  def full?
    open_board = (1..9).to_a
    open_spaces = values & open_board
    open_spaces.empty?
  end

  def available?(input)
    space = self.values[Integer(input) - 1]
    space.is_a?(Integer)
  end
end
