require 'game'
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

class TestUIForGame
  attr_accessor :output

  def initialize
    @output = []
  end

  def welcome
    output << 'Welcome to Tic Tac Toe!'
  end

  def goodbye
    output << 'Thank you for playing. Goodbye!'
  end
end

class TestGameLooper
  attr_accessor :messages_sent

  def initialize
    @messages_sent = []
  end

  def loop
    messages_sent << 'Loop'
  end
end

describe 'Game' do
  context '#run', integration: true do
    it 'plays the game' do
      ui = TestUIForGame.new
      game_looper = TestGameLooper.new
      game = Game.new(ui:, game_looper:)

      game.run

      expected_output = ['Welcome to Tic Tac Toe!', 'Thank you for playing. Goodbye!']
      expected_messages_sent = ['Loop']
      expect(ui.output).to eq(expected_output)
      expect(game_looper.messages_sent).to eq(expected_messages_sent)
    end

    it 'exits the game when there is a win' do
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

      game = Game.new(ui:, game_looper:)

      allow($stdin).to receive(:gets).and_return('9')
      board.values = [
        'X', '0', 3,
        4, 'X', 'O',
        7, 8, 9
      ]

      game.run

      output = $stdout.string.split("\n")
      expect(output).to include('Thank you for playing. Goodbye!')

      $stdout = original_stdout
    end

    it 'exits the game when there is a draw' do
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
      game = Game.new(ui:, game_looper:)

      allow($stdin).to receive(:gets).and_return('7')
      board.values = [
        'X', '0', '0',
        'O', 'O', 'X',
        7, 'X', 'O'
      ]

      game.run

      output = $stdout.string.split("\n")
      expect(output).to include('Thank you for playing. Goodbye!')

      $stdout = original_stdout
    end
  end
end
