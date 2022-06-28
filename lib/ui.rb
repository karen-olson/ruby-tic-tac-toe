class UI
  def initialize(display:, prompter:)
    @display = display
    @prompter = prompter
  end

  def get_move(player:)
    prompter.call(player:)
  end

  def display_board(board)
    display.present(board)
  end

  def with_greeting_and_salutation(&block)
    display.message(welcome_message)
    block.call
    display.message(goodbye_message)
  end

  def display_outcome(outcome_checker:, final_player:)
    display.message(win_message(final_player)) if outcome_checker.win?

    display.message(draw_message) if outcome_checker.draw?
  end

  private

  attr_reader :display, :prompter

  def welcome_message
    'Welcome to Tic Tac Toe!'
  end

  def goodbye_message
    'Thank you for playing. Goodbye!'
  end

  def win_message(final_player)
    "#{final_player.marker} is the winner!"
  end

  def draw_message
    'Draw 😕'
  end
end
