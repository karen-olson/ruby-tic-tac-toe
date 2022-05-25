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
  
  class TestDisplay
    def present(board)
      'looping'
    end
  end
  
  class TestPrompt
    def call(_message, _error_message)
      8
    end
  end

  class TestBoardForFullBoard
    attr_accessor :board_fullness_iterations, :values, :loop_number

    def initialize(board_fullness_iterations)
      @board_fullness_iterations = board_fullness_iterations
      @values = 'board values'
      @loop_number = 0
    end

    def full?
      board_fullness = board_fullness_iterations[loop_number]
      self.loop_number += 1
      board_fullness
    end

    def mark_space(token, space) end
  end

describe 'Game Looper' do
    context '#loop' do
        it 'stops looping when the board is full' do
            console = TestConsole.new
            display = TestDisplay.new
            prompt = TestPrompt.new
            board_fullness_iterations = [false, false, false, true]
            board = TestBoardForFullBoard.new(board_fullness_iterations)
            
            game_looper = GameLooper.new(console: console, display: display, prompt: prompt, board: board)

            game_looper.loop

            expected_output = ['looping', 'looping', 'looping']

            expect(console.messages).to eq(expected_output)
        end
    end
end