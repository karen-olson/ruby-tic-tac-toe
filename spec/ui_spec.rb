require 'ui'

class TestDisplayForUI
  attr_reader :displayed

  def initialize
    @displayed = []
  end

  def present(board)
    displayed << board
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

  describe '#prompt' do
    context 'when user input is requested' do
      it 'prompts the user' do
        display = TestDisplayForUI.new
        prompter = TestPrompterForUI.new
        ui = UI.new(display:, prompter:)

        ui.prompt

        expect(prompter.called).to eq(['Prompter called'])
      end
    end
  end
end
