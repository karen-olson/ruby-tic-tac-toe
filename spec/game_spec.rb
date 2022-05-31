require 'game'
require 'game_looper'
require 'console'
require 'display'
require 'prompt'
require 'board'
require 'player'
require 'number_validator'
require 'availability_validator'
require 'stringio'
require 'pry'

class TestConsole
  attr_reader :messages

  def initialize
    @messages = []
  end

  # def gets_input
  #   binding.pry
  # end

  def output(message)
    @messages << message
    binding.pry
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
  # context '#run' do
  #   it 'plays the game' do
  #     console = TestConsole.new
  #     game_looper = TestGameLooper.new(console)
  #     # allow(game_looper).to receive(:loop).and_return('Looping')

  #     game = Game.new(console: console, game_looper: game_looper)

  #     game.run

  #     expected_output = ['Welcome to Tic Tac Toe!', 'Looping', 'Thank you for playing. Goodbye!']

  #     expect(console.messages).to eq(expected_output)
  #   end
  # end

  context 'when the board is full' do
    it 'exits the game' do
      original_stdout = $stdout
      $stdout = StringIO.new
      allow($stdin).to receive(:gets).and_return('9')
      console = Console.new(stdin: $stdin, stdout: $stdout)
      
      board = Board.new
      board.values = ['X', '0', '0', 'X', 'X', 'O', 'O', 'O', 9]

      number_validator = NumberValidator.new
      availability_validator = AvailabilityValidator.new(board: board)
      prompt = Prompt.new(console: console, number_validator: number_validator, availability_validator: availability_validator)

      display = Display.new

      players = [Player.new(marker: 'X'), Player.new(marker: 'O')]
      
      game_looper = GameLooper.new(console: console, display: display, prompt: prompt, board: board, players: players)
      
      game = Game.new(console: console, game_looper: game_looper)

      game.run

      output = $stdout.string.split("\n")
      expect(output).to include('Thank you for playing. Goodbye!')

      $stdout = original_stdout
    end
  end
end
