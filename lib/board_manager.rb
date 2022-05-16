class BoardManager
    attr_accessor :board

    def initialize
        @board = (1..9).to_a
    end

    def mark_space(token, space)
        board[space - 1] = token
    end
end