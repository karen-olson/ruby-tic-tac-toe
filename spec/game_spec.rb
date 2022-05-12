# frozen_string_literal: true

require 'game'

describe 'Tic Tac Toe Game' do
  it 'makes a new object' do
    game = Game.new

    expect(game).to be_instance_of(Game)
  end

  context '#display_board' do
    it 'displays an empty board before any moves have been made' do
      game = Game.new

      expect{ game.display_board }.to output("1 | 2 | 3\n-----------\n4 | 5 | 6\n-----------\n7 | 8 | 9\n").to_stdout
    end
  end

  context '#run' do
    it 'displays an empty board when the game starts' do
      game = Game.new

      expect{ game.run }.to output("Welcome to Tic Tac Toe!\n1 | 2 | 3\n-----------\n4 | 5 | 6\n-----------\n7 | 8 | 9\n").to_stdout
    end
  end

end
