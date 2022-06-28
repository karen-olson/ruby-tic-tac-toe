require_relative './player'

class ComputerPlayer < Player
  def post_initialize(opts)
    @board = opts[:board]
  end

  def select_space
    first_available_space = (1..9).find { |space| board.available?(space) }
    first_available_space.to_s
  end

  private

  attr_reader :board
end
