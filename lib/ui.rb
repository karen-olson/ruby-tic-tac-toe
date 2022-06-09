class UI
  def initialize(display:, prompter:)
    @display = display
    @prompter = prompter
  end

  def display_board(board)
    display.present(board)
  end

  def prompt
    prompter.call
  end

  private

  attr_reader :display, :prompter
end
