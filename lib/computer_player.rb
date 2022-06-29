class ComputerPlayer
  attr_reader :marker, :board

  def initialize(marker:, board:)
    @marker = marker
    @board = board
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
    srand 1234

    until selections.length == 9
      space = rand(1..9)
      selections << space unless selections.include?(space)
    end

    selections
  end
end
