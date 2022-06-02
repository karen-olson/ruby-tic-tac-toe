require 'game'
require 'game_looper'
require 'console'
require 'display'
require 'prompt'
require 'board'
require 'player'
require 'number_validator'
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
  context '#run' do
    it 'plays the game' do
      console = TestConsole.new
      game_looper = TestGameLooper.new(console)
      game = Game.new(console:, game_looper:)

      game.run

      expected_output = ['Welcome to Tic Tac Toe!', 'Looping', 'Thank you for playing. Goodbye!']
      expect(console.messages).to eq(expected_output)
    end
  end

  context 'when the board is full' do
    it 'exits the game' do
      original_stdout = $stdout
      $stdout = StringIO.new

      console = Console.new(stdin: $stdin, stdout: $stdout)
      board = Board.new
      number_validator = NumberValidator.new
      prompt = Prompt.new(console:, number_validator:, board:)
      display = Display.new
      players = [Player.new(marker: 'X'), Player.new(marker: 'O')]
      game_looper = GameLooper.new(console:, display:, prompt:, board:, players:)
      game = Game.new(console:, game_looper:)

      allow($stdin).to receive(:gets).and_return('9')
      board.values = ['X', '0', '0', 'X', 'X', 'O', 'O', 'O', 9]

      game.run

      output = $stdout.string.split("\n")
      expect(output).to include('Thank you for playing. Goodbye!')

      $stdout = original_stdout
    end
  end
end
