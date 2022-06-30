class RandomNumberGenerator
  def initialize(range:, rand: method(:rand))
    @range = range
    @rand = rand
  end

  def random_number
    @rand.call(range)
  end

  private

  attr_reader :range
end
