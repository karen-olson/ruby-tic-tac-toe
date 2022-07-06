class ComputerPlayer
  attr_reader :marker, :board, :random_number_generator

  def initialize(marker:, board:, random_number_generator:)
    @marker = marker
    @board = board
    @random_number_generator = random_number_generator
    @selections = []

    set_selections
  end

  def select_space
    selection = selections.shift

    selection = selections.shift until board.available?(selection)

    selection
  end

  private

  attr_accessor :selections

  def set_selections
    until selections.length == 9
      space = random_number_generator.random_number
      selections << space unless selections.include?(space)
    end

    selections
  end
end
