require 'pry'

class Board
  attr_accessor :values, :values_grid
  attr_reader :outcome_checker, :dimension

  def initialize(outcome_checker:)
    @outcome_checker = outcome_checker
    @values = (1..9).to_a
  end

  def get_space(row, column)
    index = (row * dimension) + column
    values[index]
  end
  
  def mark_space(token, space)
    values[space - 1] = token
  end

  def full?
    open_board = (1..values.length).to_a
    open_spaces = values & open_board
    open_spaces.empty?
  end

  def available?(input)
    space = values[input - 1]
    space.is_a?(Integer)
  end

  def has_win?
    outcome_checker.win?(self)
  end

  def has_draw?
    outcome_checker.draw?(self)
  end

  def rows
    values_grid
  end

  def columns
    values_grid.transpose
  end

  def diagonals
    [left_diagonal, right_diagonal]
  end

  private

  def dimension 
    dimension = Math.sqrt(values.length).to_i
  end

  def values_grid
    grid = []
    values.each_slice(dimension) { |row| grid << row }
    grid
  end

  def left_diagonal
    left_diagonal = []
    current_row_or_column = 0

    dimension.times do
      left_diagonal << get_space(current_row_or_column, current_row_or_column)
      current_row_or_column += 1
    end

    left_diagonal
  end

  def right_diagonal
    right_diagonal = []
    current_row = 0
    current_column = dimension - 1

    dimension.times do
      right_diagonal << get_space(current_row, current_column)
      current_row += 1
      current_column -= 1
    end

    right_diagonal
  end
end
