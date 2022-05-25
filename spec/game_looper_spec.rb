require 'game_looper'

class TestConsole
    attr_reader :messages
  
    def initialize
      @messages = []
    end
  
    def output(message)
      @messages << message
    end
  
    def gets_input
      1
    end
  end
  
  class TestDisplay
    def present(board)
      board.values
    end
  end
  
  class TestPrompt
    def call(_message, _error_message)
      8
    end
  end
  
  class TestBoard
    attr_accessor :values
  
    def initialize
      @values = 'empty board'
    end
  
    def get_space(row, column); end
  
    def mark_space(token, space)
      @values = "board with an #{token} mark in space #{space}"
    end
  end

describe 'Game Looper' do
    context '#loop' do
        it 'takes turns until the game is over' do
            console = TestConsole.new
            display = TestDisplay.new
            prompt = TestPrompt.new
            board = TestBoard.new
            
            game_looper = GameLooper.new(console, display, prompt, board)

            game_looper.loop

            expected_output = ['empty board', 'board with an X mark in space 8']

            expect(console.messages).to eq(expected_output)
        end
    end
end