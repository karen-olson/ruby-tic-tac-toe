require 'pry'

class Prompt

  attr_reader :console, :number_validator

  def initialize(console:, number_validator:)
    @console = console
    @number_validator = number_validator
  end

  def call(message, error_message)
    valid_input = nil

    until (valid_input)
      console.output(message)
      input = console.gets_input
      range = 1..9

      if number_validator.valid?(input, range)
        valid_input = Integer(input)
      else
        console.output(error_message)
      end
    end

    valid_input
  end
end
