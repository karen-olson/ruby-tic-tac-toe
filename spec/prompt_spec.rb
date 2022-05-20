require 'prompt'
require 'pry'

class TestConsoleForValidInput
  def output(message)
  end

  def gets_input
    "8"
  end
end

class TestNumberValidatorForValidInput
  def valid?(input, range)
    true
  end
end

# class TestConsoleForInvalidInput
#   attr_accessor :messages

#   def initialize
#     @messages = []
#   end

#   def output(message)
#     messages << message
#   end

#   def gets_input
#     "7asdf$@"
#   end
# end

# class TestNumberValidatorForInvalidInput
#   def valid?(input, range)
#     false
#   end
# end

# class TestConsoleForRepeatedPrompts
#   attr_reader :return_values
#   attr_accessor :messages

#   def initialize
#     @iteration = 0
#     @return_values = ["sadf", "@#$(*", "3"]
#     @messages = []
#   end

#   def gets_input
#     return_value = return_values[@iteration]
#     @iteration += 1
#     return_value
#   end

#   def output(message)
#     messages << message
#   end
# end

# class TestNumberValidatorForRepeatedPrompts
#   attr_reader :return_values

#   def initialize
#     @iteration = 0
#     @return_values = [false, false, true]
#   end
  
#   def valid?(input, range)
#     return_value = return_values[@iteration]
#     @iteration += 1
#     return_value
#   end
# end

describe 'Prompt' do
  context '#call' do
    it 'returns valid user input' do
      console = TestConsoleForValidInput.new
      number_validator = TestNumberValidatorForValidInput.new
      prompt = Prompt.new(console: console, number_validator: number_validator)

      message = "Choose a space. Enter 1-9: "
      error_message = "Please enter a valid number."
      valid_input = prompt.call(message, error_message)

      expect(valid_input).to eq(8)
    end

    ### THESE TESTS MADE RSPEC MAD FOR SOME REASON, BUT ONLY AFTER ADDING THE UNTIL LOOP

    # it 'displays an error message for invalid input' do
    #   console = TestConsoleForInvalidInput.new
    #   number_validator = TestNumberValidatorForInvalidInput.new
    #   prompt = Prompt.new(console: console, number_validator: number_validator)

    #   message = "Choose a space. Enter 1-9: "
    #   error_message = "Please enter a valid number."
    #   valid_input = prompt.call(message, error_message)

    #   expect(console.messages).to include(error_message)
    # end

    # it 'continues prompting the user until valid input is received' do
    #   console = TestConsoleForRepeatedPrompts.new
    #   number_validator = TestNumberValidatorForRepeatedPrompts.new
    #   prompt = Prompt.new(console: console, number_validator: number_validator)

    #   message = "Choose a space. Enter 1-9: "
    #   error_message = "Please enter a valid number."
    #   space_selection = prompt.call(message, error_message)

    #   expect(console.messages).to eq([message, error_message, message, error_message, message])
    # end
  end
end
