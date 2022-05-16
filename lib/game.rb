class Game
  attr_reader :console, :welcome_message, :display, :prompt

  def initialize(console, welcome_message, display, prompt, board_manager)
    @console = console
    @welcome_message = welcome_message
    @display = display
    @prompt = prompt
    @board_manager = board_manager
  end

  def run
    welcome_player
    display_board
    prompt_player_to_choose_space
    place_mark_on_board
    # display_board
  end

  private

  def welcome_player
    console.output(welcome_message)
  end

  def display_board
    # display will need to take in the current board state 
    # (board_manager.board)
    console.output(display.present)
  end

  def prompt_player_to_choose_space
    console.output(prompt.choose_a_space)
  end
  
  # def get_player_token
  # 
  # end

  # def get_player_input
  #   # 
  # end

  def place_mark_on_board(token, space)
    # token = get_player_token
    # space = get_player_input
    # board_manager.mark_space(token, space)
  end
end
