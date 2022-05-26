require 'pry'

class GameLooper
    private
    attr_reader :console, :welcome_message, :display, :prompt, :board, :players
    
    public
    def initialize(console:, display:, prompt:, board:, players:)
        @console = console
        @welcome_message = welcome_message
        @display = display
        @prompt = prompt
        @board = board
        @players = players
    end

    def loop
        until game_is_over
            take_turns(players)
        end
        display_board
    end

    private 

    def game_is_over
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
        
        move = prompt.call(message, error_message)
    end

    def mark_board(player, move)
        board.mark_space(player.marker, move)
    end
end