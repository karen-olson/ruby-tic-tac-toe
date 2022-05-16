# frozen_string_literal: true

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

describe 'Tic Tac Toe Game' do

  context '#run' do
    it 'displays an empty board when the game starts' do
      console = TestConsole.new
      message = "Welcome to Tic Tac Toe!\n"

      game = Game.new(console, message)

      game.console.output(message)
      # game.run

      expect(game.console.messages).to include(message)

      # How to build test double to make assertions about how the game class will 
      # interact with testconsole object? Assert on that instead. 
      # Log string pattern in TDD by Example (could be array).

      # Build and test real console that you're going to inject in main (bin/run)
    end
  end

  def empty_board
    "1 | 2 | 3\n-----------\n4 | 5 | 6\n-----------\n7 | 8 | 9"
  end
end
