require 'pry'

class Prompt
  def initialize(console:, board:, number_validator:)
    @console = console
    @board = board
    @number_validator = number_validator
    @space = nil
  end

  def call(player:)
    self.valid_input = nil

    until valid_input
      input = get_input(player:)
      validate_input(input:, range: 1..9)
    end

    valid_input
  end

  private

  attr_reader :console, :board, :number_validator
  attr_accessor :valid_input, :space_number

  def get_input(player:)
    console.output('Please choose a space.')
    player.select_space
  end

  def validate_input(input:, range:)
    validate_number(input:, range:)

    validate_availability(space_number:) if space_number

    reset_space_number
  end

  def validate_number(input:, range:)
    if number_validator.valid?(input, range)
      self.space_number = Integer(input)
    else
      console.output('Please enter a valid number.')
    end
  end

  def validate_availability(space_number:)
    if board.available?(space_number)
      self.valid_input = space_number
    else
      console.output("Space number #{space_number} is already taken.")
    end
  end

  def reset_space_number
    self.space_number = nil
  end
end
