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
  def present(board_values)
    board_values
  end
end

class TestPrompt
  def choose_a_space
    'choose a space'
  end
end

class TestBoardManager
  attr_accessor :board_values

  def initialize
    @board_values = 'empty board'
  end

  def mark_space(_token, _space)
    @board_values = 'board with one X mark'
  end
end

describe 'Game' do
  context '#run' do
    it 'plays the game' do
      console = TestConsole.new
      welcome_message = 'Hello player!'
      display = TestDisplay.new
      prompt = TestPrompt.new
      board_manager = TestBoardManager.new

      game = Game.new(console, welcome_message, display, prompt, board_manager)

      game.run

      expected_output = [welcome_message, 'empty board', 'choose a space', 'board with one X mark']

      expect(game.console.messages).to eq(expected_output)
    end
  end
end
