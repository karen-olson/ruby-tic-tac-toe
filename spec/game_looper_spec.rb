require 'game_looper'

class TestConsole
  attr_reader :messages

  def initialize
    @messages = []
  end

  def output(message)
    @messages << message
  end
end

class TestPlayer
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TestBoard
  def mark_space(_message, _error_message); end
end

class TestDisplay end

class TestPrompt
  def call(_message, _error_message); end
end

class TestOutcomeCheckerForGameLooper
  # attr_reader :test_draw, :test_win
  def initialize(board:)
    @board = board
    # @test_draw = test_draw
    # @test_win = test_win
  end

  # def win?
  #   test_win
  # end

  # def draw?
  #   test_draw
  # end
end

describe 'Game Looper' do
  context '#loop' do
    it 'loops until there is a draw' do
      console = TestConsole.new
      prompt = TestPrompt.new
      board = TestBoard.new
      display = TestDisplay.new
      outcome_checker = TestOutcomeCheckerForGameLooper.new(board:)
      player_one = TestPlayer.new('X')
      player_two = TestPlayer.new('O')
      players = [player_one, player_two]

      allow(outcome_checker).to receive(:draw?).and_return(false, false, false, false, true)
      allow(outcome_checker).to receive(:win?).and_return(false, false, false, false, false)

      allow(display).to receive(:present).and_return('board', 'board', 'board_with_draw')

      game_looper = GameLooper.new(console:, prompt:, board:, display:,
                                   players:, outcome_checker:)

      game_looper.loop

      expected_console_messages = %w[board board board_with_draw]

      expect(console.messages).to eq(expected_console_messages)
    end

    it 'loops until there is a win' do
      console = TestConsole.new
      prompt = TestPrompt.new
      board = TestBoard.new
      display = TestDisplay.new
      outcome_checker = TestOutcomeCheckerForGameLooper.new(board:)
      player_one = TestPlayer.new('X')
      player_two = TestPlayer.new('O')
      players = [player_one, player_two]

      allow(outcome_checker).to receive(:draw?).and_return(false, false, false, false, false)
      allow(outcome_checker).to receive(:win?).and_return(false, false, false, false, true)

      allow(display).to receive(:present).and_return('board', 'board', 'board_with_win')

      game_looper = GameLooper.new(console:, prompt:, board:, display:,
                                   players:, outcome_checker:)

      game_looper.loop

      expected_console_messages = %w[board board board_with_win]

      expect(console.messages).to eq(expected_console_messages)
    end

    # it 'gives each player a turn' do
    #     console = TestConsole.new
    #     prompt = TestPrompt.new
    #     board = TestBoard.new
    #     display = TestDisplay.new
    #     player_one = TestPlayer.new('X')
    #     player_two = TestPlayer.new('O')
    #     players = [player_one, player_two]

    #     allow(board).to receive(:full?).and_return(false, false, true)
    #     allow(board).to receive(:mark_space).and_return('empty board',
    #     'board with an X in space 8', 'board with an O in space 2')
    #     allow(board).to receive(:values).and_return()

    #     allow(display).to receive(:present).and_return()

    #     game_looper = GameLooper.new(console: console, prompt: prompt,
    #     board: board, display: display, players: players)

    #     game_looper.loop

    #     expected_console_messages = ['empty board', 'board with X in space 8', 'board with O in space 2']

    #     expect(console.messages).to eq(expected_console_messages)
    # end
  end
end
