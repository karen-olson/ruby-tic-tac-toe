require 'game_looper'

class TestPlayer
  attr_reader :marker

  def initialize(marker:)
    @marker = marker
  end
end

class RecordMessages
  def initialize
    @events = []
    @moves = [1, 2]
  end

  attr_reader :events

  def display_board(_board)
    events << 'display board'
  end

  def get_move
    events << 'prompt user'
    @moves.shift
  end

  def mark_space(marker, move)
    events << "#{marker} moves to #{move}"
  end
end

class HasOutcomeFor
  def initialize(rounds:)
    @rounds = Array.new(rounds + 1) { false } << true
  end

  def game_over?
    @rounds.shift
  end

  def win?
    true
  end

  def draw?
    false
  end
end

describe 'Game Looper' do
  describe '#loop' do
    it 'loops through turns until the game is over' do
      outcome_checker = HasOutcomeFor.new(rounds: 2)
      player_one = TestPlayer.new(marker: 'X')
      player_two = TestPlayer.new(marker: 'O')
      players = [player_one, player_two]

      messages = RecordMessages.new

      game_looper = GameLooper.new(ui: messages, board: messages, players:, outcome_checker:)

      game_looper.loop

      expect(messages.events).to eq([
                                      'display board',
                                      'prompt user',
                                      'X moves to 1',
                                      'display board',
                                      'prompt user',
                                      'O moves to 2'
                                    ])
    end
  end
end
