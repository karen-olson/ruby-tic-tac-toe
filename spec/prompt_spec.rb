require 'prompt'
require 'pry'

class TestConsoleForValidInput
  def output(message) end

  def gets_input
    '8'
  end
end

class TestNumberValidatorForValidInput
  def valid?(_input, _range)
    true
  end
end

class TestConsoleForRepeatedPrompts
  attr_reader :return_values
  attr_accessor :messages, :iteration

  def initialize
    @iteration = 0
    @return_values = %w[sadf 3]
    @messages = []
  end

  def gets_input
    return_value = return_values[@iteration]
    self.iteration += 1
    return_value
  end

  def output(message)
    messages << message
  end
end

class TestNumberValidatorForRepeatedPrompts
  attr_reader :return_values

  def initialize
    @iteration = 0
    @return_values = [false, true]
  end

  def valid?(_input, _range)
    return_value = return_values[@iteration]
    @iteration += 1
    return_value
  end
end

describe 'Prompt' do
  context '#call' do
    it 'returns valid user input' do
      console = TestConsoleForValidInput.new
      number_validator = TestNumberValidatorForValidInput.new
      prompt = Prompt.new(console:, number_validator:)

      message = 'Choose a space. Enter 1-9: '
      error_message = 'Please enter a valid number.'
      valid_input = prompt.call(message, error_message)

      expect(valid_input).to eq(8)
    end

    it 'continues prompting the user until valid input is received' do
      console = TestConsoleForRepeatedPrompts.new
      number_validator = TestNumberValidatorForRepeatedPrompts.new
      prompt = Prompt.new(console:, number_validator:)

      message = 'Choose a space. Enter 1-9: '
      error_message = 'Please enter a valid number.'
      prompt.call(message, error_message)

      expect(console.messages).to eq([message, error_message, message])
    end
  end
end
