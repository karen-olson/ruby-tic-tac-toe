require 'pry'

class Prompt

  attr_reader :console, :number_validator
  attr_accessor :valid_input

  def initialize(console:, number_validator:)
    @console = console
    @number_validator = number_validator
    @valid_input = nil
  end

  def call(message, error_message)
    until (valid_input)
      console.output(message)
      input = console.gets_input
      range = 1..9

      validate_input(input, range, error_message)
    end

    valid_input
  end

  private

  def validate_input(input, range, error_message)
    if number_validator.valid?(input, range)
      self.valid_input = Integer(input)
    else
      console.output(error_message)
    end
  end

end
