require 'random_number_generator'

describe 'Random Number Generator' do
    it 'returns a random number' do
        range = 1..9
        random_number_generator = RandomNumberGenerator.new(range:)

        random_numbers = []

        10.times do
            random_numbers << random_number_generator.random_number
        end

        number_of_unique_random_numbers = random_numbers.uniq.length
        expect(number_of_unique_random_numbers).to be > (3)
    end
end