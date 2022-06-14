class UI
  def initialize(display:, prompter:)
    @display = display
    @prompter = prompter
  end

  def get_move
    prompter.call
  end

  def display_board(board)
    display.present(board)
  end

  def with_greeting_and_salutation(&block)
    display.message(welcome_message)
    block.call
    display.message(goodbye_message)
  end

  private

  attr_reader :display, :prompter

  def welcome_message
    'Welcome to Tic Tac Toe!'
  end

  def goodbye_message
    'Thank you for playing. Goodbye!'
  end
end
