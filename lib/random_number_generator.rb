class RandomNumberGenerator

    def initialize(range:)
        @range = range
        srand 1234
    end

    def random_number
        rand(range)
    end

    private

    attr_reader :range
end