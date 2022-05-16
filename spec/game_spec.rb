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

describe 'Tic Tac Toe Game' do
  context '#run' do
    it 'plays the game' do
      console = TestConsole.new
      welcome_message = 'Hello player!'
      display = TestDisplay.new

      game = Game.new(console, welcome_message, display)

      game.run

      expected_messages = [welcome_message, 'board']

      expect(game.console.messages).to eq(expected_messages)

      # How to build test double to make assertions about how the game class will
      # interact with testconsole object? Assert on that instead.
      # Log string pattern in TDD by Example (could be array).

      # Build and test real console that you're going to inject in main (bin/run)
    end
  end
end
