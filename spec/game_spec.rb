# frozen_string_literal: true

require 'game'

describe 'Tic Tac Toe Game' do
  before(:example) do
    @game = Game.new
  end

  context '#display_board' do
    it 'displays an empty board before any moves have been made' do
      expect { @game.display_board }.to output("#{empty_board}\n").to_stdout
    end
  end

  context '#run' do
    it 'displays an empty board when the game starts' do
      welcome_message = "Welcome to Tic Tac Toe!\n"

      expect { @game.run }.to output("#{welcome_message + empty_board}\n").to_stdout
    end
  end

  def empty_board
    "1 | 2 | 3\n-----------\n4 | 5 | 6\n-----------\n7 | 8 | 9"
  end
end
