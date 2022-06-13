class Game
  def initialize(ui:, game_looper:)
    @ui = ui
    @game_looper = game_looper
  end

  def run
    ui.welcome
    game_looper.loop
    ui.goodbye
  end

  private

  attr_reader :game_looper, :ui
end
