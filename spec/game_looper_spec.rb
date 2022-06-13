require 'game_looper'
require 'console'
require 'display'
require 'prompt'
require 'board'
require 'player'
require 'number_validator'
require 'outcome_checker'
require 'ui'
require 'stringio'
require 'pry'

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
    context 'given real objects', integration: true do
      it 'loops until there is a draw' do
        original_stdout = $stdout
        $stdout = StringIO.new

        console = Console.new(stdin: $stdin, stdout: $stdout)
        board = Board.new
        outcome_checker = OutcomeChecker.new(board:)
        number_validator = NumberValidator.new
        prompter = Prompt.new(console:, number_validator:, board:)
        display = Display.new(console:)
        ui = UI.new(display:, prompter:)
        players = [Player.new(marker: 'X'), Player.new(marker: 'O')]
        game_looper = GameLooper.new(ui:, board:, players:, outcome_checker:)

        allow($stdin).to receive(:gets).and_return('7')
        board.values = [
          'X', '0', '0',
          'O', 'O', 'X',
          7, 'X', 'O'
        ]

        game_looper.loop

        output = $stdout.string.split("\n")
        expected_output = [
          " X | 0 | 0", 
          "---+---+---", 
          " O | O | X", 
          "---+---+---", 
          " 7 | X | O", 
          "Please choose a space.", 
          " X | 0 | 0", 
          "---+---+---", 
          " O | O | X", 
          "---+---+---", 
          " X | X | O"
        ]
        expect(output).to eq(expected_output)

        $stdout = original_stdout
      end
    end

    context 'given test doubles' do
      it 'loops until there is a draw' do
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

    context 'given real objects', integration: true do
      it 'loops until there is a win' do
        original_stdout = $stdout
        $stdout = StringIO.new

        console = Console.new(stdin: $stdin, stdout: $stdout)
        board = Board.new
        outcome_checker = OutcomeChecker.new(board:)
        number_validator = NumberValidator.new
        prompter = Prompt.new(console:, number_validator:, board:)
        display = Display.new(console:)
        ui = UI.new(display:, prompter:)
        players = [Player.new(marker: 'X'), Player.new(marker: 'O')]
        game_looper = GameLooper.new(ui:, board:, players:, outcome_checker:)

        allow($stdin).to receive(:gets).and_return('9')
        board.values = [
          'X', 2,  3,
           4, 'X', 6,
           7,  8,  9
        ]

        game_looper.loop

        output = $stdout.string.split("\n")
        expected_output = [
          " X | 2 | 3", 
          "---+---+---", 
          " 4 | X | 6", 
          "---+---+---", 
          " 7 | 8 | 9", 
          "Please choose a space.", 
          " X | 2 | 3", 
          "---+---+---", 
          " 4 | X | 6", 
          "---+---+---", 
          " 7 | 8 | X"
        ]
        expect(output).to eq(expected_output)

        $stdout = original_stdout
      end
    end

    context 'given test doubles' do
      it 'loops until there is a win' do
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
