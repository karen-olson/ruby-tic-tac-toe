require 'number_validator'

describe 'Number Validator' do
  context 'valid?' do
    it 'correctly validates a number within the given range' do
      number_validator = NumberValidator.new
      input = '8'
      range = 1..9

      expect(number_validator.valid?(input, range)).to eq true
    end

    it 'determines when the given input is not a number' do
      number_validator = NumberValidator.new
      input = '1as#=df'
      range = 1..9

      expect(number_validator.valid?(input, range)).to eq false
    end

    it 'determines when a number is not within the given range' do
      number_validator = NumberValidator.new
      input = '10'
      range = 1..9

      expect(number_validator.valid?(input, range)).to eq false
    end
  end
end
