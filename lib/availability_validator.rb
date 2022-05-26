class AvailabilityValidator
    attr_reader :board

    def initialize(board:)
        @board = board
    end

    def available?(input)
        space = board.values[input - 1]
        space.is_a?(Integer)
    end

end