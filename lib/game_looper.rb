# dependencies:
#   board?
#   console
#   prompt
#   display

class GameLooper
    attr_reader :console, :welcome_message, :display, :prompt, :board
    attr_accessor :latest_move
    
    def initialize(console, display, prompt, board)
        @console = console
        @welcome_message = welcome_message
        @display = display
        @prompt = prompt
        @board = board
        @latest_move = nil
    end

    def loop
        # until game_is_over
            take_turn
        # end
    end

    private 

    def take_turn
        display_board
        get_move
        place_mark_on_board
        # remove this once looping is introduced
        display_board
    end

    def display_board
        board_display = display.present(board)
        console.output(board_display)
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