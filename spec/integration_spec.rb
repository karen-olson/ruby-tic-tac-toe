require 'game_looper'
require 'console'
require 'display'
require 'prompt'
require 'board'
require 'player'
require 'number_validator'
require 'outcome_checker'
require 'ui'
require 'stringio'

describe 'Integration', integration: true do
  it 'plays a draw game' do
    original_stdout = $stdout
    $stdout = StringIO.new

    console = Console.new(stdin: $stdin, stdout: $stdout)
    board = Board.new
    outcome_checker = OutcomeChecker.new(board:)
    number_validator = NumberValidator.new
    prompter = Prompt.new(console:, number_validator:, board:)
    display = Display.new(console:)
    ui = UI.new(display:, prompter:)
    players = [Player.new(marker: 'X'), Player.new(marker: 'O')]
    game_looper = GameLooper.new(ui:, board:, players:, outcome_checker:)

    allow($stdin).to receive(:gets).and_return('7')
    board.values = [
      'X', '0', '0',
      'O', 'O', 'X',
      7, 'X', 'O'
    ]

    game_looper.play

    output = $stdout.string.split("\n")
    expected_output = [
      'Welcome to Tic Tac Toe!',
      ' X | 0 | 0',
      '---+---+---',
      ' O | O | X',
      '---+---+---',
      ' 7 | X | O',
      'Please choose a space.',
      ' X | 0 | 0',
      '---+---+---',
      ' O | O | X',
      '---+---+---',
      ' X | X | O',
      'Draw 😕', 
      'Thank you for playing. Goodbye!'
    ]
    expect(output).to eq(expected_output)

    $stdout = original_stdout
  end

  it 'plays a game that has a winner' do
    original_stdout = $stdout
    $stdout = StringIO.new

    console = Console.new(stdin: $stdin, stdout: $stdout)
    board = Board.new
    outcome_checker = OutcomeChecker.new(board:)
    number_validator = NumberValidator.new
    prompter = Prompt.new(console:, number_validator:, board:)
    display = Display.new(console:)
    ui = UI.new(display:, prompter:)
    players = [Player.new(marker: 'X'), Player.new(marker: 'O')]
    game_looper = GameLooper.new(ui:, board:, players:, outcome_checker:)

    allow($stdin).to receive(:gets).and_return('9')
    board.values = [
      'X', 2, 3,
      4, 'X', 6,
      7, 8, 9
    ]

    game_looper.play

    output = $stdout.string.split("\n")
    expected_output = [
      'Welcome to Tic Tac Toe!',
      ' X | 2 | 3',
      '---+---+---',
      ' 4 | X | 6',
      '---+---+---',
      ' 7 | 8 | 9',
      'Please choose a space.',
      ' X | 2 | 3',
      '---+---+---',
      ' 4 | X | 6',
      '---+---+---',
      ' 7 | 8 | X',
      'X is the winner!', 
      'Thank you for playing. Goodbye!'
    ]
    expect(output).to eq(expected_output)

    $stdout = original_stdout
  end
end
