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

class TestGameLooper
  attr_reader :console

  def initialize(console)
    @console = console
  end

  def loop
    console.output('Looping')
  end
end

describe 'Game' do
  context '#run' do
    it 'plays the game' do
      console = TestConsole.new
      welcome_message = 'Hello player!'
      game_looper = TestGameLooper.new(console)

      game = Game.new(console, welcome_message, game_looper)

      game.run

      expected_output = [welcome_message, 'Looping']

      expect(console.messages).to eq(expected_output)
    end
  end
end
