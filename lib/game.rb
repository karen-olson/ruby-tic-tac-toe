require 'pry'

class Game
  attr_reader :game_looper, :ui

  def initialize(ui:, game_looper:)
    @ui = ui
    @game_looper = game_looper
  end

  def run
    ui.welcome
    game_looper.loop
    ui.goodbye
  end
end
