require 'game'
require 'console'
require 'display'
require 'prompt'
require 'board'
require 'human_player'
require 'number_validator'
require 'outcome_checker'
require 'ui'
require 'stringio'

describe 'Integration', integration: true do
  it 'plays a draw game' do
    test_stdout = StringIO.new
    test_stdin = StringIO.new('7')

    console = Console.new(stdin: test_stdin, stdout: test_stdout)
    board = Board.new
    outcome_checker = OutcomeChecker.new(board:)
    number_validator = NumberValidator.new
    prompter = Prompt.new(console:, number_validator:, board:)
    display = Display.new(console:)
    ui = UI.new(display:, prompter:)
    players = [HumanPlayer.new(marker: 'X', ui:), HumanPlayer.new(marker: 'O', ui:)]
    game = Game.new(ui:, board:, players:, outcome_checker:)

    board.values = [
      'X', '0', '0',
      'O', 'O', 'X',
      7, 'X', 'O'
    ]

    game.play

    output = test_stdout.string
    expected_output = <<~EXPECTED_OUTPUT
      Welcome to Tic Tac Toe!
       X | 0 | 0
      ---+---+---
       O | O | X
      ---+---+---
       7 | X | O
      #{' '}
      Please choose a space.
       X | 0 | 0
      ---+---+---
       O | O | X
      ---+---+---
       X | X | O
      #{' '}
      Draw 😕
      Thank you for playing. Goodbye!
    EXPECTED_OUTPUT

    expect(output).to eq(expected_output)
  end

  it 'plays a game that has a winner' do
    test_stdout = StringIO.new
    test_stdin = StringIO.new('9')

    console = Console.new(stdin: test_stdin, stdout: test_stdout)
    board = Board.new
    outcome_checker = OutcomeChecker.new(board:)
    number_validator = NumberValidator.new
    prompter = Prompt.new(console:, number_validator:, board:)
    display = Display.new(console:)
    ui = UI.new(display:, prompter:)
    players = [HumanPlayer.new(marker: 'X', ui:), HumanPlayer.new(marker: 'O', ui:)]
    game = Game.new(ui:, board:, players:, outcome_checker:)

    board.values = [
      'X', 2, 3,
      4, 'X', 6,
      7, 8, 9
    ]

    game.play

    output = test_stdout.string
    expected_output = <<~EXPECTED_OUTPUT
      Welcome to Tic Tac Toe!
       X | 2 | 3
      ---+---+---
       4 | X | 6
      ---+---+---
       7 | 8 | 9
      #{' '}
      Please choose a space.
       X | 2 | 3
      ---+---+---
       4 | X | 6
      ---+---+---
       7 | 8 | X
      #{' '}
      X is the winner!
      Thank you for playing. Goodbye!
    EXPECTED_OUTPUT

    expect(output).to eq(expected_output)
  end
end
