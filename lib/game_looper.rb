class GameLooper
  attr_accessor :current_player

  def initialize(ui:, board:, players:, outcome_checker:)
    @ui = ui
    @board = board
    @players = players
    @outcome_checker = outcome_checker
    @current_player = players[0]
  end

  def loop
    take_turns(players) until game_is_over
  end

  private

  attr_reader :ui, :board, :players, :outcome_checker

  def game_is_over
    outcome_checker.game_over?
  end

  def take_turns(players)
    players.each do |player|
      ui.display_board(board)
      take_turn(player) unless game_is_over
    end
  end

  def take_turn(player)
    self.current_player = player.marker
    move = ui.get_move
    mark_board(player, move)
  end

  def mark_board(player, move)
    board.mark_space(player.marker, move)
  end
end
