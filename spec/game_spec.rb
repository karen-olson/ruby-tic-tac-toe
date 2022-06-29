require 'game'

class TestHumanPlayer
  attr_reader :marker, :ui

  def initialize(marker:, ui:)
    @marker = marker
    @ui = ui
  end

  def select_space
    ui.get_move
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

  def with_greeting_and_salutation(&block)
    events << 'welcome'
    block.call
    events << 'goodbye'
  end

  def display_outcome(outcome_checker:, final_player:)
    events << 'display outcome'
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

describe 'Game' do
  describe '#play' do
    it 'plays the game' do
      messages = RecordMessages.new
      outcome_checker = HasOutcomeFor.new(rounds: 2)
      player_one = TestHumanPlayer.new(marker: 'X', ui: messages)
      player_two = TestHumanPlayer.new(marker: 'O', ui: messages)
      players = [player_one, player_two]


      game = Game.new(ui: messages, board: messages, players:, outcome_checker:)

      game.play

      expect(messages.events).to eq([
                                      'welcome',
                                      'display board',
                                      'prompt user',
                                      'X moves to 1',
                                      'display board',
                                      'prompt user',
                                      'O moves to 2',
                                      'display board',
                                      'display outcome',
                                      'goodbye'
                                    ])
    end
  end
end
