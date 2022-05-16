# frozen_string_literal: true

# Game class for Tic Tac Toe game
class Game
  attr_reader :console, :welcome_message, :display

  def initialize(console, welcome_message, display)
    @console = console
    @welcome_message = welcome_message
    @display = display
  end

  def run
    welcome_player
    display_board
  end

  private

  def welcome_player
    console.output(welcome_message)
  end

  def display_board
    console.output(display.present)
  end
end
