require 'random_number_generator'

describe 'Random Number Generator' do
  it 'returns a random number' do
    range = 1..9
    something_like_rand = ->(range) { range.last }
    random_number_generator = RandomNumberGenerator.new(range:, rand: something_like_rand)

    expect(random_number_generator.random_number).to be(range.last)
  end
end
