require 'game'
require 'pry'

class TestConsole
  attr_reader :messages

  def initialize
    @messages = []
  end

  def output(message)
    @messages << message
  end
end

class TestGameLooper

end

describe 'Game' do
  context '#run' do
    it 'plays the game' do
      console = TestConsole.new
      game_looper = TestGameLooper.new
      allow(game_looper).to receive(:loop).and_return('Looping')

      game = Game.new(console: console, game_looper: game_looper)

      game.run

      expected_output = ['Welcome to Tic Tac Toe!', 'Looping', 'Thank you for playing. Goodbye!']

      expect(console.messages).to eq(expected_output)
    end
  end

  context 'when the board is full' do
    it 'exits the game' do

    end
  end

  # context 'spike acceptance test' do
  #   it 'exits with a code of 0' do
  #       exit_code = system('ruby bin/run', exception: true)
  #       puts "exit code: #{exit_code}"
  #       puts "#{$?.to_s}"

  #   end
  # end
end
