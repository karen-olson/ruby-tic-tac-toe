require 'pry'

class Game
  attr_reader :console, :welcome_message, :display, :prompt, :board
  attr_accessor :latest_move

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
    # start game loop
    # until game_is_over
    get_move
    # if I want the player to be able to end the game at any time, check for exit command here
    place_mark_on_board
    display_board
    # check for conditions that would end the game
    #     winner?, tie?
    # end game loop
    # display_results
  end

  private

  def welcome_player
    console.output(welcome_message)
  end

  def display_board
    console.output(display.present(board))
  end

  def get_move
    message = 'Enter a number 1-9: '
    error_message = 'Please enter a valid number.'

    self.latest_move = prompt.call(message, error_message)
  end

  def place_mark_on_board
    board.mark_space('X', latest_move)
  end
end
