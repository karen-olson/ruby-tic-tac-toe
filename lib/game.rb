require 'pry'

class Game
  attr_reader :console, :welcome_message, :display, :prompt, :board

  # attr_accessor :latest_move

  def initialize(console, welcome_message, display, prompt, board)
    @console = console
    @welcome_message = welcome_message
    @display = display
    @prompt = prompt
    @board = board
    @latest_move = nil
  end

  def run
    welcome_player
    display_board
    prompt_player_to_choose_space
    gets_move
    place_mark_on_board
    display_board
  end

  private

  def welcome_player
    console.output(welcome_message)
  end

  def display_board
    console.output(display.present(board))
  end

  def prompt_player_to_choose_space
    console.output(prompt.choose_a_space)
  end

  def gets_move
    @latest_move = console.gets_input
  end

  def place_mark_on_board
    board.mark_space('X', @latest_move)
  end
end
