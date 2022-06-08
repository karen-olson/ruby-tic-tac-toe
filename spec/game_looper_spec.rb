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
  def initialize(board:)
    @board = board
  end
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
  end
end
