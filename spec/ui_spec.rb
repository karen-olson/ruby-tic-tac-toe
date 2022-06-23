require 'ui'

describe 'UI' do
  describe '#get_move' do
    context 'when user input is requested' do
      it 'prompts the player and returns their move' do

        class PromptsPlayerFor
          def initialize(move:)
            @move = move
          end

          def call
            @move
          end
        end

        class DoesNotDisplayOutput
        end

        prompter = PromptsPlayerFor.new(move: "1")
        no_display_needed = DoesNotDisplayOutput.new

        ui = UI.new(display: no_display_needed, prompter:)

        move = ui.get_move

        expect(move).to eq("1")
      end
    end
  end

  describe '#display_board' do
    context 'given a 3x3 board' do
      it 'displays it to the user' do
        class DisplaysOutput
          attr_reader :displayed
          def initialize
            @displayed = []
          end
        
          def present(board)
            @displayed << board
          end
        
          def message(message)
            @displayed << message
          end
        end

        class DoesNotPromptPlayer 
        end

        display = DisplaysOutput.new
        no_prompter_needed = DoesNotPromptPlayer.new

        ui = UI.new(display:, prompter: no_prompter_needed)

        board = 'Test board'
        ui.display_board(board)

        expect(display.displayed).to eq(['Test board'])
      end
    end
  end

  describe '#with_greeting_and_salutation' do
    context 'when called with a block argument' do
      it 'displays welcome message, executes the given block, and displays goodbye message' do
        display = DisplaysOutput.new
        no_prompter_needed = DoesNotPromptPlayer.new

        ui = UI.new(display:, prompter: no_prompter_needed)

        ui.with_greeting_and_salutation do
          display.message('Block called')
        end

        expect(display.displayed).to eq(['Welcome to Tic Tac Toe!',
                                       'Block called',
                                       'Thank you for playing. Goodbye!'])
      end
    end
  end

  describe 'display_outcome' do
    context 'when there is an outcome' do
      it 'displays the correct win message' do
        display = DisplaysOutput.new
        no_prompter_needed = DoesNotPromptPlayer.new

        ui = UI.new(display:, prompter: no_prompter_needed)

        class HasOutcomeForWin
          def win?
            true
          end
        
          def draw?
            false
          end
        end

        class TestPlayerX
          def marker
            'X'
          end
        end

        outcome_checker = HasOutcomeForWin.new
        final_player = TestPlayerX.new

        ui.display_outcome(outcome_checker:, final_player:)

        expect(display.displayed).to eq(['X is the winner!'])
      end

      it 'displays the correct draw message' do
        display = DisplaysOutput.new
        no_prompter_needed = DoesNotPromptPlayer.new

        ui = UI.new(display:, prompter: no_prompter_needed)

        class HasOutcomeForDraw
          def win?
            false
          end
        
          def draw?
            true
          end
        end

        outcome_checker = HasOutcomeForDraw.new
        final_player = TestPlayerX.new

        ui.display_outcome(outcome_checker:, final_player:)

        expect(display.displayed).to eq(['Draw 😕'])
      end
    end

    context 'when the game is in progress' do
      it 'does not display an outcome' do
        display = DisplaysOutput.new
        no_prompter_needed = DoesNotPromptPlayer.new

        ui = UI.new(display:, prompter: no_prompter_needed)

        class HasNoOutcome
          def win?
            false
          end
          
          def draw?
            false
          end

          def game_over?
            false
          end
        end

        outcome_checker = HasNoOutcome.new
        final_player = TestPlayerX.new

        ui.display_outcome(outcome_checker:, final_player:)

        expect(display.displayed).to be_empty
      end
    end
  end
end
