require 'prompt'

class TestConsoleForPrompt
  attr_reader :messages

  def initialize(input:)
    @messages = []
    @input = input
  end

  def output(message)
    @messages << message
  end

  def gets_input
    @input.shift
  end
end

class TestNumberValidator
  def valid?(input, range)
    true
  end
end

class TestNumberValidatorForRepeatedInput
  def initialize
    @valid = [false, true]
  end

  def valid?(input, range)
    @valid.shift
  end
end

class TestBoard
  def available?(input)
    true
  end
end

class TestBoardForRepeatedInput
  def initialize
    @available = [true]
  end

  def available?(input)
    @available.shift
  end
end

describe 'Prompt' do
  context '#call' do
    it 'returns valid user input' do
      console = TestConsoleForPrompt.new(input: [1])
      board = TestBoard.new
      number_validator = TestNumberValidator.new

      prompt = Prompt.new(console:, number_validator:, board:)

      expect(prompt.call).to eq(1)
    end

    it 'returns valid input after receiving invalid input' do
      console = TestConsoleForPrompt.new(input: ['asdf', 1])
      board = TestBoardForRepeatedInput.new
      number_validator = TestNumberValidatorForRepeatedInput.new

      prompt = Prompt.new(console:, number_validator:, board:)

      expect(prompt.call).to eq(1)
    end

    it 'displays the correct message (prompt message or error messsage) based on the input it receives' do
      console = TestConsoleForPrompt.new(input: ['asdf', 1])
      board = TestBoardForRepeatedInput.new
      number_validator = TestNumberValidatorForRepeatedInput.new

      prompt = Prompt.new(console:, number_validator:, board:)

      prompt.call

      prompt_message = 'Please choose a space.'
      error_message = 'Please enter a valid number.'

      expect(console.messages).to eq([prompt_message, error_message, prompt_message])
    end
  end
end
