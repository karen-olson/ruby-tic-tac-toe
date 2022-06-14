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

class TestOutcomeCheckerAlwaysResultsInDraw
  attr_accessor :board, :in_progress_values

  def initialize(board:)
    @board = board
    @in_progress_values = [true, false]
  end

  def win?
    false
  end

  def draw?
    true unless in_progress?
  end

  def in_progress?
    in_progress_values.shift
  end
end

class TestOutcomeCheckerAlwaysResultsInWin
  attr_accessor :board, :in_progress_values

  def initialize(board:)
    @board = board
    @in_progress_values = [true, false]
  end

  def win?
    true unless in_progress?
  end

  def draw?
    false
  end

  def in_progress?
    in_progress_values.shift
  end
end

class TestOutcomeCheckerWinsAfterTwoTurns
  attr_accessor :board, :in_progress_values

  def initialize(board:)
    @board = board
    @in_progress_values = [true, true, true, false]
  end

  def win?
    true unless in_progress?
  end

  def draw?
    false
  end

  def in_progress?
    in_progress_values.shift
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
    context 'given test doubles' do
      it 'loops until there is a draw' do
        ui = TestUI.new
        board = TestBoard.new

        outcome_checker = TestOutcomeCheckerAlwaysResultsInDraw.new(board:)

        player_one = TestPlayer.new('X')
        player_two = TestPlayer.new('O')
        players = [player_one, player_two]

        game_looper = GameLooper.new(ui:, board:, players:, outcome_checker:)

        game_looper.loop

        expect(ui.output).to eq(['board displayed', 'board displayed'])
      end
    end

    context 'given real objects' do
      it 'gives each player a turn until the game is over' do
        test_input = [2, 8]
        ui = TestUI.new(input: test_input)

        test_board = [
          'X',  2, 'O',
          'O', 'X', 'X',
          'O', 8, 'O'
        ]
        board = TestBoard.new(values: test_board)

        outcome_checker = TestOutcomeCheckerWinsAfterTwoTurns.new(board:)
        player_one = TestPlayer.new('X')
        player_two = TestPlayer.new('O')
        players = [player_one, player_two]

        game_looper = GameLooper.new(ui:, board:, players:, outcome_checker:)

        game_looper.loop

        expect(board.move_history).to eq(['Board with X in space 2', 'Board with O in space 8'])
      end

      class RecordMessages
        def initialize()
          @events = []
          @moves = [1, 2]
        end
        attr_reader :events

        def display_board(board)
          events << "display board"
        end

        def get_move
          events << "prompt user"
          @moves.shift
        end

        def mark_space(marker, move)
          events << "#{marker} moves to #{move}"
        end
      end

      class HasOutcomeFor
        def initialize(rounds:)
          @rounds = Array.new(rounds + 1) { |i| true }
          @winner = winner
        end

        def in_progress?
          @rounds.shift
        end

        def on_outcome(winner:, draw:, in_progress:)
          
        end
      end


      it "works" do
        outcome_checker = HasOutcomeFor.new(rounds: 2, winner: "O")
        player_one = TestPlayer.new('X')
        player_two = TestPlayer.new('O')
        players = [player_one, player_two]

        messages = RecordMessages.new

        game_looper = GameLooper.new(ui: messages, board: messages, players:, outcome_checker:)

        game_looper.loop
        expect(messages.events).to eq([
          "display board",
          "prompt user",
          "X moves to 1",
          "display board",
          "prompt user",
          "O moves to 2",
          "display board",
          "O wins"
        ])
      end
    end
  end
end