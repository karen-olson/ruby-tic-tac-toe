require 'Open3'

describe 'Acceptance', integration: true do
  it 'plays a draw game' do
    stdout_str, _stderr_str, status = Open3.capture3('ruby bin/run', stdin_data: "1\n2\n3\n5\n4\n6\n8\n7\n9\n")

    expected_output = <<~EXPECTED_OUTPUT
      Welcome to Tic Tac Toe!
       1 | 2 | 3
      ---+---+---
       4 | 5 | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | 2 | 3
      ---+---+---
       4 | 5 | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | O | 3
      ---+---+---
       4 | 5 | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | O | X
      ---+---+---
       4 | 5 | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | O | X
      ---+---+---
       4 | O | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | O | X
      ---+---+---
       X | O | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | O | X
      ---+---+---
       X | O | O
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | O | X
      ---+---+---
       X | O | O
      ---+---+---
       7 | X | 9
      Please choose a space.
       X | O | X
      ---+---+---
       X | O | O
      ---+---+---
       O | X | 9
      Please choose a space.
       X | O | X
      ---+---+---
       X | O | O
      ---+---+---
       O | X | X
      Draw 😕
      Thank you for playing. Goodbye!
    EXPECTED_OUTPUT

    expect(stdout_str).to eq(expected_output)
    expect(status.exitstatus).to eq(0)
  end

  it 'plays a winning game' do
    stdout_str, _stderr_str, status = Open3.capture3('ruby bin/run', stdin_data: "1\n4\n2\n5\n3\n")

    expected_output = <<~EXPECTED_OUTPUT
      Welcome to Tic Tac Toe!
       1 | 2 | 3
      ---+---+---
       4 | 5 | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | 2 | 3
      ---+---+---
       4 | 5 | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | 2 | 3
      ---+---+---
       O | 5 | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | X | 3
      ---+---+---
       O | 5 | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | X | 3
      ---+---+---
       O | O | 6
      ---+---+---
       7 | 8 | 9
      Please choose a space.
       X | X | X
      ---+---+---
       O | O | 6
      ---+---+---
       7 | 8 | 9
      X is the winner!
      Thank you for playing. Goodbye!
    EXPECTED_OUTPUT

    expect(stdout_str).to eq(expected_output)
    expect(status.exitstatus).to eq(0)
  end
end
