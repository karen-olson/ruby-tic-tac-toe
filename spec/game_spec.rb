# frozen_string_literal: true

require 'game'

class TestConsole
  def output(message)
    puts(message)
  end

  # def initialize
  #   @messages = []
  # end

  # def output(message)
  #   @messages << message
  # end
end

describe 'Tic Tac Toe Game' do

  context '#run' do
    it 'displays an empty board when the game starts' do
      console = TestConsole.new
      game = Game.new(console)

      welcome_message = "Welcome to Tic Tac Toe!\n"

      expect { game.run }.to output("#{welcome_message + empty_board}\n").to_stdout
      
      # How to build test double to make assertions about how the game class will 
      # interact with testconsole object? Assert on that instead. 
      # Log string pattern in TDD by Example (could be array).
      
      # game.console.output(message)
      # expect(console.message).to contain(message)

      # Build and test real console that you're going to inject in bin/run
    end
  end

  def empty_board
    "1 | 2 | 3\n-----------\n4 | 5 | 6\n-----------\n7 | 8 | 9"
  end
end
