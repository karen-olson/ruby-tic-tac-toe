# frozen_string_literal: true

class Console 
  def output(message)
    puts message
  end
end

# Main class for Tic Tac Toe game
class Game
  @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  BOARD_DISPLAY = "#{@board[0]} | #{@board[1]} | #{@board[2]}" \
                  "\n-----------\n#{@board[3]} | #{@board[4]} | #{@board[5]}" +
                  "\n-----------\n#{@board[6]} | #{@board[7]} | #{@board[8]}".freeze

  def initialize(console)
    @console = console
    @welcome_message = 'Welcome to Tic Tac Toe!'
  end

  def run
    print_to_console
  end

  private

  def print_to_console
    @console.output("#{@welcome_message}\n#{BOARD_DISPLAY}")
  end
end
