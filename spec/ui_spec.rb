require 'ui'

class RecordMessagesForUI
  attr_reader :events

  def initialize
    @events = []
  end

  def present(board)
    events << "#{board} displayed"
  end

  def message(message)
    events << "Displayed message '#{message}'"
  end

  def call
    events << 'Prompt called and user input returned'
  end
end

class HasOutcomeForWin
  def win?
    true
  end

  def draw?
    false
  end
end

class HasOutcomeForDraw
  def win?
    false
  end

  def draw?
    true
  end
end

class TestPlayerX
  def marker
    'X'
  end
end

describe 'UI' do
  describe '#get_move' do
    context 'when user input is requested' do
      it 'prompts the player and returns their move selection' do
        messages = RecordMessagesForUI.new
        ui = UI.new(display: messages, prompter: messages)

        ui.get_move

        expect(messages.events).to eq(['Prompt called and user input returned'])
      end
    end
  end

  describe '#display_board' do
    context 'given a 3x3 board' do
      it 'displays it to the user' do
        messages = RecordMessagesForUI.new
        ui = UI.new(display: messages, prompter: messages)

        board = 'Test board'
        ui.display_board(board)

        expect(messages.events).to eq(['Test board displayed'])
      end
    end
  end

  describe '#with_greeting_and_salutation' do
    context 'when called' do
      it 'displays welcome message, executes the given block, and displays goodbye message' do
        messages = RecordMessagesForUI.new
        ui = UI.new(display: messages, prompter: messages)

        ui.with_greeting_and_salutation do
          messages.message('Block called')
        end

        expect(messages.events).to eq(["Displayed message 'Welcome to Tic Tac Toe!'",
                                       "Displayed message 'Block called'", "Displayed message 'Thank you for playing. Goodbye!'"])
      end
    end
  end

  describe 'display_outcome' do
    context 'when there is an outcome' do
      it 'displays the correct win message' do
        messages = RecordMessagesForUI.new
        ui = UI.new(display: messages, prompter: messages)

        outcome_checker = HasOutcomeForWin.new
        final_player = TestPlayerX.new

        ui.display_outcome(outcome_checker:, final_player:)

        expect(messages.events).to eq(["Displayed message 'X is the winner!'"])
      end

      it 'displays the correct draw message' do
        messages = RecordMessagesForUI.new
        ui = UI.new(display: messages, prompter: messages)

        outcome_checker = HasOutcomeForDraw.new
        final_player = TestPlayerX.new

        ui.display_outcome(outcome_checker:, final_player:)

        expect(messages.events).to eq(["Displayed message 'Draw 😕'"])
      end
    end
  end
end
