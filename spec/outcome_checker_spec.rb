require 'outcome_checker'
require 'pry'

class TestBoard
  attr_accessor :test_rows, :test_columns, :test_diagonals, :test_full

  def initialize(test_rows: [], test_columns: [], test_diagonals: [], test_full: false)
    @test_rows = test_rows
    @test_columns = test_columns
    @test_diagonals = test_diagonals
    @test_full = test_full
  end

  def get_space(row, column)
    index = (row * 3) + column
    values[index]
  end

  def rows
    test_rows
  end

  def columns
    test_columns
  end

  def diagonals
    test_diagonals
  end

  def full?
    test_full
  end
end

def rows_with_one_win
  [
    %w[X X X],
    %w[O X O],
    ['O', 8, 'O']
  ]
end

def rows_with_no_wins
  [
    %w[O X O],
    %w[X X O],
    ['X', 2, 'O']
  ]
end 

def columns_with_one_win
  [
    ['O', 'X', 'X'],
    ['X', 'X',  2 ],
    ['O', 'O', 'O']
  ]
end

def columns_with_no_wins
  [
    %w[X O O],
    [2,  'X', 8],
    %w[X O X]
  ]
end

def diagonals_with_one_win
  [
    %w[X X X],
    %w[X X O]
  ]
end

def diagonals_with_no_wins
  [
    %w[X O X],
    %w[X X O]
  ]
end

def full_rows_with_no_wins
  [
    %w[X O X],
    %w[O X X],
    %w[O X O]
  ]
end

def full_columns_with_no_wins
  [
    %w[X O O],
    %w[O X X],
    %w[X X O]
  ]
end

def full_diagonals_with_no_wins 
  [
    %w[X X O],
    %w[O X X]
  ]
end

describe 'Outcome Checker' do
  context '#win?' do
    it 'returns true with 1 winning row' do
      board = TestBoard.new(test_rows: rows_with_one_win, test_columns: columns_with_no_wins, test_diagonals: diagonals_with_no_wins, test_full: false)
      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.win?(board)).to eq(true)
    end

    it 'returns true with 1 winning column' do
      board = TestBoard.new(test_rows: rows_with_no_wins, test_columns: columns_with_one_win, test_diagonals: diagonals_with_no_wins, test_full: false)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.win?(board)).to eq(true)
    end

    it 'returns true with 1 winning diagonal' do
      board = TestBoard.new(test_rows: rows_with_no_wins, test_columns: columns_with_no_wins, test_diagonals: diagonals_with_one_win, test_full: false)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.win?(board)).to eq(true)
    end

    it 'returns false with 0 winning rows, columns, or diagonals and an empty space' do
      board = TestBoard.new(test_rows: rows_with_no_wins, test_columns: columns_with_no_wins, test_diagonals: diagonals_with_no_wins, test_full: false)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.win?(board)).to eq(false)
    end

    it 'returns false with 0 winning rows, columns, or diagonals and no empty spaces' do
      board = TestBoard.new(test_rows: full_rows_with_no_wins, test_columns: full_columns_with_no_wins, test_diagonals: full_diagonals_with_no_wins, test_full: true)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.win?(board)).to eq(false)
    end
  end

  context '#draw?' do
    it 'returns true when the board is full and #win? is false' do
      board = TestBoard.new(test_rows: full_rows_with_no_wins, test_columns: full_columns_with_no_wins, test_diagonals: full_diagonals_with_no_wins, test_full: true)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.draw?(board)).to eq(true)
    end

    it 'returns false when the board is not full' do
      board = TestBoard.new(test_rows: rows_with_one_win, test_columns: columns_with_no_wins, test_diagonals: diagonals_with_no_wins, test_full: false)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.draw?(board)).to eq(false)
    end

    it 'returns false when the board is full and #win? is true' do
      board = TestBoard.new(test_rows: rows_with_one_win, test_full: true)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.draw?(board)).to eq(false)
    end
  end
end
