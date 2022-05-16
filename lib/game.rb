# frozen_string_literal: true

# Game class for Tic Tac Toe game
class Game
  attr_reader :console, :message, :board

  @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  BOARD_DISPLAY = "#{@board[0]} | #{@board[1]} | #{@board[2]}" \
                  "\n-----------\n#{@board[3]} | #{@board[4]} | #{@board[5]}" +
                  "\n-----------\n#{@board[6]} | #{@board[7]} | #{@board[8]}".freeze

  def initialize(console, message)
    @console = console
    @message = message
  end

  def run
    print_to_console
  end

  private

  def print_to_console
    @console.output(message)
  end
end
