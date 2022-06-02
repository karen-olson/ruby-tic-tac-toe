require 'prompt'
require 'pry'

class TestConsole
  attr_accessor :messages

  def initialize
    @messages = []
  end

  def output(message)
    messages << message
  end
end

class TestNumberValidator
end

class TestBoard
end

describe 'Prompt' do
  context '#call' do
    it 'returns valid user input' do
      console = TestConsole.new
      board = TestBoard.new
      number_validator = TestNumberValidator.new

      allow(console).to receive(:gets_input).and_return(8)
      allow(number_validator).to receive(:valid?).and_return(true)
      allow(board).to receive(:available?).and_return(true)

      prompt = Prompt.new(console:, number_validator:, board:)

      message = 'Choose a space. Enter 1-9: '
      error_message = 'Please enter a valid number.'
      valid_input = prompt.call(message, error_message)

      expect(valid_input).to eq(8)
    end

    it 'continues prompting the user until valid input is received' do
      console = TestConsole.new
      board = TestBoard.new
      number_validator = TestNumberValidator.new

      allow(console).to receive(:gets_input).and_return('asdf', 1)
      allow(number_validator).to receive(:valid?).and_return(false, true)
      allow(board).to receive(:available?).and_return(true)

      prompt = Prompt.new(console:, number_validator:, board:)

      message = 'Choose a space. Enter 1-9: '
      error_message = 'Please enter a valid number.'
      valid_input = prompt.call(message, error_message)

      expect(valid_input).to eq(1)
      expect(console.messages).to eq([message, error_message, message])
    end
  end
end
