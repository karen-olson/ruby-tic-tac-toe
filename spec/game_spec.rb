require 'game'

class RecordMessages
  def initialize
    @events = []
    @selections = [1, 2]
    @markers = ['X', 'O']
  end

  attr_reader :events

  def display_board(_board)
    events << 'display board'
  end

  def select_space
    events << 'select space'
    @selections.shift
  end

  def marker
    @markers.shift
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

      game = Game.new(ui: messages, board: messages, players: [messages, messages], outcome_checker:)

      game.play

      expect(messages.events).to eq([
                                      'welcome',
                                      'display board',
                                      'select space',
                                      'X moves to 1',
                                      'display board',
                                      'select space',
                                      'O moves to 2',
                                      'display board',
                                      'display outcome',
                                      'goodbye'
                                    ])
    end
  end
end
