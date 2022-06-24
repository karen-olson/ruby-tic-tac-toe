require 'open3'

describe 'Acceptance', integration: true do
  it 'plays a draw game' do
    stdout_str, status = Open3.capture2('ruby bin/run', stdin_data: "1\n2\n3\n5\n4\n6\n8\n7\n9\n")

    output = stdout_str.downcase

    expect(output).to include('welcome', 'draw', 'goodbye')
    expect(status.exitstatus).to eq(0)
  end

  it 'plays a winning game' do
    stdout_str, status = Open3.capture2('ruby bin/run', stdin_data: "1\n4\n2\n5\n3\n")

    output = stdout_str.downcase

    expect(output).to include('welcome', 'x is the winner', 'goodbye')
    expect(status.exitstatus).to eq(0)
  end
end
