require 'pry'

class Game
  attr_reader :console, :game_looper

  def initialize(console:, game_looper:)
    @console = console
    @game_looper = game_looper
  end

  def run
    welcome_players
    game_looper.loop
    goodbye_players
  end

  private

  def welcome_players
    console.output('Welcome to Tic Tac Toe!')
  end

  def goodbye_players
    console.output('Thank you for playing. Goodbye!')
  end
end
