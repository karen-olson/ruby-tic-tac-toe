class Prompt
  attr_accessor :console

  def initialize(console:, number_validator:)
    @console = console
    @number_validator = number_validator
  end

  def call(message)
  # def call(message, validate)
    # get input from user
    input = console.gets_input

    # pass input into validate
    if number_validator.valid?(input)
      # if valid, maybe cast and return to user
      input.to_i
    else
      # otherwise display error message and retry
      console.output(message)
      # retry
    end
  end

  def choose_a_space
    'Choose a space. Enter 1-9:'
  end
end
