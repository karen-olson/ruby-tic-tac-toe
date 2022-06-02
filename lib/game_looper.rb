require 'pry'

class GameLooper
  # private

  def initialize(console:, display:, prompt:, board:, players:)
    @console = console
    @display = display
    @prompt = prompt
    @board = board
    @players = players
  end

  def loop
    take_turns(players) until game_is_over
    display_board
  end

  private

  attr_reader :console, :display, :prompt, :board, :players

  def game_is_over
    # binding.pry
    board.full?
  end

  def take_turns(players)
    players.each do |player|
      take_turn(player) unless game_is_over
    end
  end

  def take_turn(player)
    display_board
    move = get_move
    mark_board(player, move)
  end

  def display_board
    board_display = display.present(board)
    console.output(board_display)
  end

  def get_move
    message = 'Enter a number 1-9: '
    error_message = 'Please enter a valid number.'

    prompt.call(message, error_message)
  end

  def mark_board(player, move)
    board.mark_space(player.marker, move)
  end
end
