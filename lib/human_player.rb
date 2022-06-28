require_relative './player'

class HumanPlayer < Player
  attr_reader :console

  def select_space
    console.gets_input
  end

  private

  def post_initialize(opts)
    @console = opts[:console]
  end
end
