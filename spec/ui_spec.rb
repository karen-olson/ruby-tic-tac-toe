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

class TestOutcomeCheckerForUI
  attr_reader :win_value, :draw_value

  def initialize(win_value: false, draw_value: false)
    @win_value = win_value
    @draw_value = draw_value
  end

  def win?
    win_value
  end

  def draw?
    draw_value
  end
end

class TestPlayerForUI
  attr_reader :marker
  def initialize(marker:)
    @marker = marker
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

  describe 'display_outcome' do
    context 'when there is an outcome' do
      it 'displays the correct win message' do
        display = TestDisplayForUI.new
        prompter = TestPrompterForUI.new
        outcome_checker = TestOutcomeCheckerForUI.new(win_value: true)
        final_player = TestPlayerForUI.new(marker: 'X')

        ui = UI.new(display:, prompter:)

        ui.display_outcome(outcome_checker:, final_player:)

        expect(display.displayed).to eq(['X is the winner!'])
      end

      it 'displays the correct draw message' do
        display = TestDisplayForUI.new
        prompter = TestPrompterForUI.new
        outcome_checker = TestOutcomeCheckerForUI.new(draw_value: true)
        final_player = 'X'

        ui = UI.new(display:, prompter:)

        ui.display_outcome(outcome_checker:, final_player:)

        expect(display.displayed).to eq(['Draw 😕'])
      end
    end
  end
end
