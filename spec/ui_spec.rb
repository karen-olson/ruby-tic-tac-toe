require 'ui'

class TestDisplayForUI
  attr_reader :displayed

  def initialize
    @displayed = []
  end

  def present(board)
    displayed << board
  end

  def message(message)
    displayed << message
  end
end

class TestPrompterForUI
  attr_reader :called

  def initialize
    @called = []
  end

  def call
    called << 'Prompter called'
  end
end

describe 'UI' do
  describe '#display_board' do
    context 'given a 3x3 board' do
      it 'displays it to the user' do
        display = TestDisplayForUI.new
        prompter = TestPrompterForUI.new
        ui = UI.new(display:, prompter:)
        board = 'board displayed to user'

        ui.display_board(board)

        expect(display.displayed).to eq(['board displayed to user'])
      end
    end
  end

  describe '#get_move' do
    context 'when user input is requested' do
      it "gets the next player's move" do
        display = TestDisplayForUI.new
        prompter = TestPrompterForUI.new
        ui = UI.new(display:, prompter:)

        ui.get_move

        expect(prompter.called).to eq(['Prompter called'])
      end
    end
  end

  describe '#with_greeting_and_salutation' do
    context 'when called' do
      it 'displays messages to the user and executes the given block' do
        display = TestDisplayForUI.new
        prompter = TestPrompterForUI.new
        ui = UI.new(display:, prompter:)

        ui.with_greeting_and_salutation do
          display.message('Block called')
        end

        expect(display.displayed).to eq(['Welcome to Tic Tac Toe!', 'Block called', 'Thank you for playing. Goodbye!'])
      end
    end
  end
end
