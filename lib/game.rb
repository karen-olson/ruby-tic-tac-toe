# frozen_string_literal: true

# Main class for Tic Tac Toe game
class Game
  
  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    @board_display = "#{@board[0]} | #{@board[1]} | #{@board[2]}\n-----------\n#{@board[3]} | #{@board[4]} | #{@board[5]}\n-----------\n#{@board[6]} | #{@board[7]} | #{@board[8]}"

    @welcome_message = 'Welcome to Tic Tac Toe!'
  end
  
  def run
    print_to_console
  end

  def print_to_console
    puts @welcome_message + "\n" + @board_display
  end

end
