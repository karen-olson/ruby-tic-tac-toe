require 'game'

class TestConsole
  attr_reader :messages

  def initialize
    @messages = []
  end

  def output(message)
    @messages << message
  end
end

class TestDisplay
  def present
    'board'
  end
end

class TestPrompt
  def choose_a_space
    'choose'
  end
end

describe 'Tic Tac Toe Game' do
  context '#run' do
    it 'plays the game' do
        console = TestConsole.new
        welcome_message = 'Hello player!'
        display = TestDisplay.new
        prompt = TestPrompt.new

        game = Game.new(console, welcome_message, display, prompt)

        game.run

        expected_output = [welcome_message, 'board', 'choose']

        expect(game.console.messages).to eq(expected_output)
    end
  end
end
