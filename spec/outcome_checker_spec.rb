require 'outcome_checker'

class TestBoardForOutcomeChecker
  attr_accessor :test_combinations

  def initialize(test_combinations:)
    @test_combinations = test_combinations
  end

  def get_space(_row, _column); end

  def mark_space(token, space); end

  def available?; end

  def combinations
    test_combinations
  end
end

def test_combinations_win_with_full_board
  rows = [
    ['X', 'O', 'X'],
    ['O', 'X', 'O'],
    ['X', 'X', 'O']
  ]
  columns = rows.transpose
  diagonals = [ ['X', 'X', 'O'], ['X', 'X', 'X']]

  rows + columns + diagonals
end

def test_combinations_win_with_open_spaces
  rows = [
    [ 1,  2, 'X'],
    [ 4, 'X', 6 ],
    ['X', 8,  9 ]
  ]
  columns = rows.transpose
  diagonals = [ [1, 'X', 9], ['X', 'X', 'X'] ]

  rows + columns + diagonals
end

def test_combinations_no_win_with_open_spaces
  rows = [
    [ 1,  2, 'X'],
    [ 4, 'O', 6 ],
    ['X', 8,  9 ]
  ]
  columns = rows.transpose
  diagonals = [ [1, 'O', 9], ['X', 'O', 'X'] ]

  rows + columns + diagonals
end

def test_combinations_draw
  rows = [
    ['X', 'O', 'X'],
    ['O', 'O', 'X'],
    ['X', 'X', 'O']
  ]
  columns = rows.transpose
  diagonals = [['X', 'O', 'O'], ['X', 'O', 'X']]

  rows + columns + diagonals
end

describe 'Outcome Checker' do
  describe '#win?' do
    context 'with 1 winning line and a full board' do
      it 'returns true' do
        board = TestBoardForOutcomeChecker.new(test_combinations: test_combinations_win_with_full_board)

        outcome_checker = OutcomeChecker.new(board:)

        expect(outcome_checker.win?).to eq(true)
      end
    end

    context 'with 1 winning line and open spaces on the board' do
      it 'returns true' do
        board = TestBoardForOutcomeChecker.new(test_combinations: test_combinations_win_with_open_spaces)

        outcome_checker = OutcomeChecker.new(board:)

        expect(outcome_checker.win?).to eq(true)
      end
    end

    context 'with no winning combinations and open spaces on the board' do
      it 'returns false' do
        board = TestBoardForOutcomeChecker.new(test_combinations: test_combinations_no_win_with_open_spaces)

        outcome_checker = OutcomeChecker.new(board:)

        expect(outcome_checker.win?).to eq(false)
      end
    end

    context 'with a draw' do
      it 'returns false' do
        board = TestBoardForOutcomeChecker.new(test_combinations: test_combinations_draw)

        outcome_checker = OutcomeChecker.new(board:)

        expect(outcome_checker.win?).to eq(false)
      end
    end
  end

  describe '#draw?' do
    context 'when the board is full and #win? is false' do
      it 'returns true' do
        board = TestBoardForOutcomeChecker.new(test_combinations: test_combinations_draw)

        outcome_checker = OutcomeChecker.new(board:)

        expect(outcome_checker.draw?).to eq(true)
      end
    end

    context 'when the board is not full and #win? is false' do
      it 'returns false' do
        board = TestBoardForOutcomeChecker.new(test_combinations: test_combinations_no_win_with_open_spaces)

        outcome_checker = OutcomeChecker.new(board:)

        expect(outcome_checker.draw?).to eq(false)
      end
    end

    context 'when the board is full and #win? is true' do
      it 'returns false' do
        board = TestBoardForOutcomeChecker.new(test_combinations: test_combinations_win_with_full_board)

        outcome_checker = OutcomeChecker.new(board:)

        expect(outcome_checker.draw?).to eq(false)
      end
    end
  end

  describe '#game_over?' do
    context 'when the game is not over' do
      it 'returns false' do
        board = TestBoardForOutcomeChecker.new(test_combinations: test_combinations_no_win_with_open_spaces)

        outcome_checker = OutcomeChecker.new(board:)

        expect(outcome_checker.game_over?).to eq(false)
      end
    end

    context 'when there is a win' do
      it 'returns true' do
        board = TestBoardForOutcomeChecker.new(test_combinations: test_combinations_win_with_open_spaces)

        outcome_checker = OutcomeChecker.new(board:)

        expect(outcome_checker.game_over?).to eq(true)
      end
    end

    context 'when there is a draw' do
      it 'returns true' do
        board = TestBoardForOutcomeChecker.new(test_combinations: test_combinations_draw)

        outcome_checker = OutcomeChecker.new(board:)

        expect(outcome_checker.game_over?).to eq(true)
      end
    end
  end
end
