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

describe 'Game Looper' do
  context '#loop' do
    it 'stops looping when the board is full' do
      console = TestConsole.new
      prompt = TestPrompt.new
      board = TestBoard.new
      display = TestDisplay.new
      player_one = TestPlayer.new('X')
      player_two = TestPlayer.new('O')
      players = [player_one, player_two]

      allow(board).to receive(:full?).and_return(false, false, false, false, true)

      allow(display).to receive(:present).and_return('board', 'board', 'full_board')

      game_looper = GameLooper.new(console:, prompt:, board:, display:,
                                   players:)

      game_looper.loop

      expected_console_messages = %w[board board full_board]

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
