# frozen_string_literal: true

# Main class for Tic Tac Toe game
class Game
  def run
    puts 'Welcome to Tic Tac Toe!'
    display_board
  end

  def display_board
    puts "1 | 2 | 3\n-----------\n4 | 5 | 6\n-----------\n7 | 8 | 9"
  end
end
