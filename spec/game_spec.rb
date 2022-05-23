require 'game'

class TestConsole
  attr_reader :messages

  def initialize
    @messages = []
  end

  def output(message)
    @messages << message
  end

  def gets_input
    1
  end
end

class TestDisplay
  def present(board)
    board.values
  end
end

class TestPrompt
  def call(_message, _error_message)
    8
  end
end

class TestBoard
  attr_accessor :values

  def initialize
    @values = 'empty board'
  end

  def get_space(row, column); end

  def mark_space(token, space)
    @values = "board with an #{token} mark in space #{space}"
  end
end

describe 'Game' do
  context '#run' do
    it 'plays the game' do
      console = TestConsole.new
      welcome_message = 'Hello player!'
      display = TestDisplay.new
      prompt = TestPrompt.new
      board = TestBoard.new

      game = Game.new(console, welcome_message, display, prompt, board)

      game.run

      expected_output = [welcome_message, 'empty board', 'board with an X mark in space 8']

      expect(console.messages).to eq(expected_output)
    end
  end
end
