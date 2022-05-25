require 'pry'

class Game
  attr_reader :console, :welcome_message, :game_looper

  def initialize(console:, welcome_message:, game_looper:)
    @console = console
    @welcome_message = welcome_message
    @game_looper = game_looper
  end

  def run
    welcome_player
    # configure_game
    game_looper.loop
    # display_results
  end

  private

  def welcome_player
    console.output(welcome_message)
  end
end
