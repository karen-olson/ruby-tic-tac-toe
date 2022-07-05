class HumanPlayer
  attr_reader :marker

  def initialize(marker:, ui:)
    @marker = marker
    @ui = ui
  end

  def select_space
    ui.get_move
  end

  private

  attr_reader :ui
end
