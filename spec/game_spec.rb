require 'game'
require 'game_looper'
require 'console'
require 'display'
require 'prompt'
require 'board'
require 'player'
require 'number_validator'
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

class TestGameLooper
  attr_reader :console

  def initialize(console)
    @console = console
  end

  def loop
    console.output('Looping')
  end
end

describe 'Game' do
  context '#run', :integration => true do
    it 'plays the game' do
      console = TestConsole.new
      game_looper = TestGameLooper.new(console)
      game = Game.new(console:, game_looper:)

      game.run

      expected_output = ['Welcome to Tic Tac Toe!', 'Looping', 'Thank you for playing. Goodbye!']
      expect(console.messages).to eq(expected_output)
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
      game = Game.new(console:, game_looper:)

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
      game = Game.new(console:, game_looper:)

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
