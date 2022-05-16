class Game
  attr_reader :console, :welcome_message, :display, :prompt

  def initialize(console, welcome_message, display, prompt)
    @console = console
    @welcome_message = welcome_message
    @display = display
    @prompt = prompt
  end

  def run
    welcome_player
    display_board
    prompt_player_to_choose_space
  end

  private

  def welcome_player
    console.output(welcome_message)
  end

  def display_board
    console.output(display.present)
  end

  def prompt_player_to_choose_space
    console.output(prompt.choose_a_space)
  end
end
