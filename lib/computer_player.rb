class ComputerPlayer
  attr_reader :marker, :board

  def initialize(marker:, board:)
    @marker = marker
    @board = board
  end

  def select_space
    (1..9).find { |space| board.available?(space) }
  end
end
