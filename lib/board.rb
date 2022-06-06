require 'pry'

class Board
  attr_accessor :values
  attr_reader :outcome_checker, :dimension

  def initialize(outcome_checker:)
    @outcome_checker = outcome_checker
    @values = (1..9).to_a
    @dimension = Math.sqrt(values.length).to_i
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
    row_numbers.map { |row_number| row(row_number) }
  end

  def columns
    column_numbers.map { |column_number| column(column_number) }
  end

  def diagonals
    [left_diagonal, right_diagonal]
  end

  private

  def row_numbers
    max_row_number = dimension - 1
    (0..max_row_number).to_a
  end

  def column_numbers
    max_column_number = dimension - 1
    (0..max_column_number).to_a
  end

  def row(row_number)
    column_numbers.map do |column_number|
      get_space(row_number, column_number)
    end
  end

  def column(column_number)
    row_numbers.map do |row_number|
      get_space(row_number, column_number)
    end
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
