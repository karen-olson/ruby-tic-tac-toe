# frozen_string_literal: true

require 'game'

describe 'Tic Tac Toe Game' do
  it 'makes a new object' do
    game = Game.new

    expect(game).to be_instance_of(Game)
  end
end
