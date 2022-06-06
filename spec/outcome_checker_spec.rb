require 'outcome_checker'
require 'pry'

class TestBoard
  def get_space(row, column)
    index = (row * 3) + column
    values[index]
  end
end

describe 'Outcome Checker' do
  context '#win?' do
    it 'returns true with 1 winning row' do
      board = TestBoard.new
      rows_with_one_winning_row = [
        %w[X X X],
        %w[O X O],
        ['O', 8, 'O']
      ]
      allow(board).to receive(:rows).and_return(rows_with_one_winning_row)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.win?(board)).to eq(true)
    end

    it 'returns true with 1 winning column' do
      board = TestBoard.new
      rows_with_no_winning_rows = [
        %w[O X O],
        %w[X X O],
        ['X', 2, 'O']
      ]
      columns_with_one_winning_column = [
        %w[O X X],
        ['X', 'X', 2],
        %w[O O O]
      ]
      allow(board).to receive(:rows).and_return(rows_with_no_winning_rows)
      allow(board).to receive(:columns).and_return(columns_with_one_winning_column)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.win?(board)).to eq(true)
    end

    it 'returns true with 1 winning diagonal' do
      board = TestBoard.new
      rows_with_no_winning_rows = [
        ['X', 2, 'X'],
        %w[O X O],
        ['O', 8, 'X']
      ]
      columns_with_no_winning_columns = [
        %w[X O O],
        [2,  'X', 8],
        %w[X O X]
      ]
      diagonals_with_one_winning_diagonal = [
        %w[X X X],
        %w[X X O]
      ]
      allow(board).to receive(:rows).and_return(rows_with_no_winning_rows)
      allow(board).to receive(:columns).and_return(columns_with_no_winning_columns)
      allow(board).to receive(:diagonals).and_return(diagonals_with_one_winning_diagonal)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.win?(board)).to eq(true)
    end

    it 'returns false with 0 winning rows, columns, or diagonals and an empty space' do
      board = TestBoard.new
      rows_with_no_winning_rows = [
        %w[X O X],
        %w[O X X],
        ['O', 8, 'O']
      ]
      columns_with_no_winning_columns = [
        %w[X O O],
        ['O', 'X', 8],
        %w[X X O]
      ]
      diagonals_with_no_winning_diagonals = [
        %w[X X O],
        %w[O X X]
      ]
      allow(board).to receive(:rows).and_return(rows_with_no_winning_rows)
      allow(board).to receive(:columns).and_return(columns_with_no_winning_columns)
      allow(board).to receive(:diagonals).and_return(diagonals_with_no_winning_diagonals)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.win?(board)).to eq(false)
    end

    it 'returns false with 0 winning rows, columns, or diagonals and no empty spaces' do
      board = TestBoard.new
      rows_with_no_winning_rows = [
        %w[X O X],
        %w[O X X],
        %w[O X O]
      ]
      columns_with_no_winning_columns = [
        %w[X O O],
        %w[O X X],
        %w[X X O]
      ]
      diagonals_with_no_winning_diagonals = [
        %w[X X O],
        %w[O X X]
      ]
      allow(board).to receive(:rows).and_return(rows_with_no_winning_rows)
      allow(board).to receive(:columns).and_return(columns_with_no_winning_columns)
      allow(board).to receive(:diagonals).and_return(diagonals_with_no_winning_diagonals)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.win?(board)).to eq(false)
    end
  end

  context '#draw?' do
    it 'returns true when the board is full and #win? is false' do
      board = TestBoard.new
      rows_with_no_winning_rows = [
        %w[X O X],
        %w[O X X],
        %w[O X O]
      ]
      columns_with_no_winning_columns = [
        %w[X O O],
        %w[O X X],
        %w[X X O]
      ]
      diagonals_with_no_winning_diagonals = [
        %w[X X O],
        %w[O X X]
      ]
      allow(board).to receive(:rows).and_return(rows_with_no_winning_rows)
      allow(board).to receive(:columns).and_return(columns_with_no_winning_columns)
      allow(board).to receive(:diagonals).and_return(diagonals_with_no_winning_diagonals)
      allow(board).to receive(:full?).and_return(true)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.draw?(board)).to eq(true)
    end

    it 'returns false when the board is not full' do
      board = TestBoard.new
      allow(board).to receive(:full?).and_return(false)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.draw?(board)).to eq(false)
    end

    it 'returns false when the board is full and #win? is true' do
      board = TestBoard.new
      rows_with_one_winning_row = [
        %w[X X X],
        %w[O X O],
        %w[O O O]
      ]
      allow(board).to receive(:full?).and_return(true)
      allow(board).to receive(:rows).and_return(rows_with_one_winning_row)

      outcome_checker = OutcomeChecker.new

      expect(outcome_checker.draw?(board)).to eq(false)
    end
  end
end
