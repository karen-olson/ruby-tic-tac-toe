require 'game_looper'

class TestConsole
  attr_reader :messages

  def initialize
    @messages = []
  end

  def output(message)
    @messages << message
  end
end

class TestPlayer
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TestBoard
  attr_reader :values
  attr_accessor :move_history

  def initialize(values: nil)
    @values = values
    @move_history = []
  end

  def mark_space(token, space)
    move_history << "Board with #{token} in space #{space}"
  end
end

class TestOutcomeCheckerForGameLooper
  attr_accessor :board, :win_values, :draw_values

  def initialize(board:, win_values:, draw_values:)
    @board = board
    @win_values = win_values
    @draw_values = draw_values
  end

  def win?
    win_values.shift
  end

  def draw?
    draw_values.shift
  end
end

class TestUI
  attr_reader :output, :input

  def initialize(input: [])
    @output = []
    @input = input
  end

  def display_board(_board)
    output << 'board displayed'
  end

  def get_move
    input.shift
  end
end

describe 'Game Looper' do
  describe '#loop' do
    context 'until there is a draw' do
      it 'loops' do
        ui = TestUI.new
        board = TestBoard.new

        test_win_values = [false, false, false, false]
        test_draw_values = [false, false, false, true]
        outcome_checker = TestOutcomeCheckerForGameLooper.new(board:, win_values: test_win_values,
                                                              draw_values: test_draw_values)
        player_one = TestPlayer.new('X')
        player_two = TestPlayer.new('O')
        players = [player_one, player_two]

        game_looper = GameLooper.new(ui:, board:, players:, outcome_checker:)

        game_looper.loop

        expect(ui.output).to eq(['board displayed', 'board displayed'])
      end
    end

    context 'until there is a win' do
      it 'loops' do
        ui = TestUI.new
        board = TestBoard.new

        test_win_values = [false, false, false, true]
        test_draw_values = [false, false, false, false]
        outcome_checker = TestOutcomeCheckerForGameLooper.new(board:, win_values: test_win_values,
                                                              draw_values: test_draw_values)

        player_one = TestPlayer.new('X')
        player_two = TestPlayer.new('O')
        players = [player_one, player_two]

        game_looper = GameLooper.new(ui:, board:, players:, outcome_checker:)

        game_looper.loop

        expect(ui.output).to eq(['board displayed', 'board displayed'])
      end
    end

    context 'until the game is over' do
      it 'gives each player a turn' do
        test_input = [2, 8]
        ui = TestUI.new(input: test_input)

        test_board = [
          'X', 2, 'O',
          'O', 'X', 'X',
          'O', 8, 'O'
        ]
        board = TestBoard.new(values: test_board)

        test_win_values = [false, false, false, true]
        test_draw_values = [false, false, false, false]
        outcome_checker = TestOutcomeCheckerForGameLooper.new(board:, win_values: test_win_values,
                                                              draw_values: test_draw_values)
        player_one = TestPlayer.new('X')
        player_two = TestPlayer.new('O')
        players = [player_one, player_two]

        game_looper = GameLooper.new(ui:, board:, players:, outcome_checker:)

        game_looper.loop

        expect(board.move_history).to eq(['Board with X in space 2', 'Board with O in space 8'])
      end
    end
  end
end
