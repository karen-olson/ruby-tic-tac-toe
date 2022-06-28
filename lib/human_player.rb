require_relative './player'

class HumanPlayer < Player
  def post_initialize(opts)
    @console = opts[:console]
  end

  def select_space
    console.gets_input
  end

  private

  attr_reader :console
end
