require 'prompt'

class TestConsoleForPrompt
  attr_reader :messages

  def initialize
    @messages = []
  end

  def output(message)
    @messages << message
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

class TestPlayerForPrompt
  def initialize(selections:)
    @selections = selections
  end

  def select_space
    @selections.shift
  end
end

describe 'Prompt' do
  context '#call' do
    it 'returns valid user input' do
      console = TestConsoleForPrompt.new
      number_validator = TestNumberValidator.new
      board = TestBoard.new
      player = TestPlayerForPrompt.new(selections: [1])

      prompt = Prompt.new(console:, number_validator:, board:)

      expect(prompt.call(player:)).to eq(1)
    end

    it 'returns valid input after receiving invalid input' do
      console = TestConsoleForPrompt.new
      number_validator = TestNumberValidatorForRepeatedInput.new
      board = TestBoardForRepeatedInput.new
      player = TestPlayerForPrompt.new(selections: ['asdf', 1])

      prompt = Prompt.new(console:, number_validator:, board:)

      expect(prompt.call(player:)).to eq(1)
    end

    it 'displays the correct error message when it receives an invalid number' do
      class NumberIsInvalidThenValid
        def initialize
          @valid = [false, true]
        end

        def valid?(input, range)
          @valid.shift
        end
      end

      class SpaceIsUnavailable
        def available?(space)
          true
        end
      end

      console = TestConsoleForPrompt.new
      number_validator = NumberIsInvalidThenValid.new
      board = SpaceIsUnavailable.new
      player = TestPlayerForPrompt.new(selections: ['asdf', '1'])

      prompt = Prompt.new(console:, number_validator:, board:)

      prompt.call(player:)

      prompt_message = 'Please choose a space.'
      invalid_number_message = 'Please enter a valid number.'

      expect(console.messages).to eq([prompt_message, invalid_number_message, prompt_message])
    end

    it 'displays the correct error message when it receives an unavailable space' do
      class SpaceIsUnavailableThenAvailable
        def initialize
          @available = [false, true]
        end

        def available?(input)
          @available.shift
        end
      end

      class NumberIsValid
        def valid?(input, range)
          true
        end
      end

      console = TestConsoleForPrompt.new
      board = SpaceIsUnavailableThenAvailable.new
      number_validator = NumberIsValid.new
      player = TestPlayerForPrompt.new(selections: ['1', '2'])

      prompt = Prompt.new(console:, number_validator:, board:)

      prompt.call(player:)

      prompt_message = 'Please choose a space.'
      unavailable_space_message = 'Space number 1 is already taken.'

      expect(console.messages).to eq([prompt_message, unavailable_space_message, prompt_message])
    end
  end
end
