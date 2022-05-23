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
    # prompt_player_to_choose_space
    get_move
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

  # def prompt_player_to_choose_space
  #   # console.output(prompt.choose_a_space)
  #   # message = "Enter a number 1-9: "
  #   # validate = number_validator.valid?(1..9)
  #   # space = prompt.call(message, validate)
  # end

  def get_move
    message = "Enter a number 1-9: "
    error_message = "Please enter a valid number."

    @latest_move = prompt.call(message, error_message)
  end

  def place_mark_on_board
    board.mark_space('X', @latest_move)
  end
end
