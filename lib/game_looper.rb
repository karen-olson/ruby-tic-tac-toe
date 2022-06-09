require 'pry'

class GameLooper
  def initialize(ui:, board:, players:, outcome_checker:)
    @ui = ui
    @board = board
    @players = players
    @outcome_checker = outcome_checker
  end

  def loop
    take_turns(players) until game_is_over
    display_board
  end

  private

  attr_reader :ui, :board, :players, :outcome_checker

  def game_is_over
    outcome_checker.draw? || outcome_checker.win?
  end

  def take_turns(players)
    players.each do |player|
      display_board
      take_turn(player) unless game_is_over
    end
  end

  def take_turn(player)
    move = get_move
    mark_board(player, move)
  end

  def display_board
    ui.display_board(board)
  end

  def get_move
    ui.prompt
  end

  def mark_board(player, move)
    board.mark_space(player.marker, move)
  end
end
