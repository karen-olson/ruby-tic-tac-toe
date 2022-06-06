require 'board'

class TestOutcomeChecker
  attr_reader :test_win, :test_draw

  def initialize(test_win: false, test_draw: false)
    @test_win = test_win
    @test_draw = test_draw
  end

  def win?(board)
    test_win
  end

  def draw?(board)
    test_draw
  end
end

describe 'Board' do
  context 'given a row and column number (from 0 - 2)' do
    it '#get_space returns the correct value for the given coordinates' do
      outcome_checker = TestOutcomeChecker.new
      board = Board.new(outcome_checker:)
      board.values = [1, 2, 3, 4, 5, 6, 7, 8, 9]

      expect(board.get_space(0, 0)).to eq(1)
      expect(board.get_space(2, 2)).to eq(9)
    end
  end

  context '#mark_space' do
    it 'places an X in the selected space on the board' do
      outcome_checker = TestOutcomeChecker.new
      board = Board.new(outcome_checker:)
      token = 'X'
      space = 1

      board.mark_space(token, space)

      expected_values = ['X', 2, 3, 4, 5, 6, 7, 8, 9]

      expect(board.values).to eq(expected_values)
    end
  end

  context '#full?' do
    it 'returns true when the board is full' do
      outcome_checker = TestOutcomeChecker.new
      board = Board.new(outcome_checker:)

      board.values = %w[X O O X X O X X O]

      expect(board.full?).to eq(true)
    end

    it 'returns false when the board is not full' do
      outcome_checker = TestOutcomeChecker.new
      board = Board.new(outcome_checker:)

      board.values = ['X', 2, 'O', 'X', 'X', 'O', 'X', 'X', 'O']

      expect(board.full?).to eq(false)
    end
  end

  context '#available?' do
    it 'returns true when the space is available' do
      outcome_checker = TestOutcomeChecker.new
      board = Board.new(outcome_checker:)

      board.values = ['X', 2, 3, 'O', 5, 6, 'X', 8, 9]

      expect(board.available?(6)).to eq(true)
    end

    it 'returns false when the space is not available' do
      outcome_checker = TestOutcomeChecker.new
      board = Board.new(outcome_checker:)

      board.values = ['X', 2, 3, 'O', 5, 6, 'X', 8, 9]

      expect(board.available?(7)).to eq(false)
    end
  end

  context '#rows' do
    it 'returns the correct row values' do
      outcome_checker = TestOutcomeChecker.new
      board = Board.new(outcome_checker:)
      board.values = [
        'O', 2, 'X',
        4, 'X', 'O',
        'O', 'X', 9
      ]
      expected_rows = [
        ['O', 2, 'X'],
        [4, 'X', 'O'],
        ['O', 'X', 9]
      ]

      expect(board.rows).to eq(expected_rows)
    end
  end

  context '#columns' do
    it 'returns the correct column values' do
      outcome_checker = TestOutcomeChecker.new
      board = Board.new(outcome_checker:)
      board.values = [
        'O', 2, 'X',
        4, 'X', 'O',
        'O', 'X', 9
      ]
      expected_columns = [
        ['O', 4, 'O'],
        [2, 'X', 'X'],
        ['X', 'O', 9]
      ]

      expect(board.columns).to eq(expected_columns)
    end
  end

  context '#diagonals' do
    it 'returns the correct diagonal values' do
      outcome_checker = TestOutcomeChecker.new
      board = Board.new(outcome_checker:)
      board.values = [
        'O', 2, 'X',
        4, 'X', 'O',
        'O', 'X', 9
      ]
      expected_diagonals = [
        ['O', 'X', 9],
        %w[X X O]
      ]

      expect(board.diagonals).to eq(expected_diagonals)
    end
  end

  context '#has_draw?' do
    it 'returns true when the outcome checker finds a draw' do
      outcome_checker = TestOutcomeChecker.new(test_draw: true, test_win: false)
      board = Board.new(outcome_checker:)

      expect(board.has_draw?).to eq(true)
    end

    it 'returns false when the outcome checker does not find a draw' do
      outcome_checker = TestOutcomeChecker.new(test_draw: false, test_win: false)
      board = Board.new(outcome_checker:)

      expect(board.has_draw?).to eq(false)
    end
  end

  context '#has_win?' do
    it 'returns true when the outcome checker finds a win' do
      outcome_checker = TestOutcomeChecker.new(test_draw: false, test_win: true)
      board = Board.new(outcome_checker:)

      expect(board.has_win?).to eq(true)
    end

    it 'returns false when the outcome checker does not find a win' do
      outcome_checker = TestOutcomeChecker.new(test_draw: false, test_win: false)
      board = Board.new(outcome_checker:)

      expect(board.has_win?).to eq(false)
    end
  end
end
