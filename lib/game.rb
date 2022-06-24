class Game
  attr_accessor :current_player

  def initialize(ui:, board:, players:, outcome_checker:)
    @ui = ui
    @board = board
    @players = players
    @outcome_checker = outcome_checker
    @current_player = players[0]
  end

  def play
    ui.with_greeting_and_salutation do
      loop
      ui.display_board(board)
      ui.display_outcome(outcome_checker:, final_player: current_player)
    end
  end

  private

  attr_reader :ui, :board, :players, :outcome_checker

  def loop
    take_turns(players) until game_is_over
  end

  def game_is_over
    outcome_checker.game_over?
  end

  def take_turns(players)
    players.each do |player|
      take_turn(player) unless game_is_over
    end
  end

  def take_turn(player)
    ui.display_board(board)
    self.current_player = player
    move = ui.get_move
    mark_board(player, move)
  end

  def mark_board(player, move)
    marker = player.marker
    board.mark_space(marker, move)
  end
end
