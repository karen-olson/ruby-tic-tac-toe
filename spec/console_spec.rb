require 'console'

class TestStdout
  attr_reader :messages

  def initialize
    @messages = []
  end

  def puts(message)
    messages << message
    nil
  end
end

class TestStdin
  def gets
    'user input'
  end
end

describe 'Console' do
  context '#output' do
    it 'prints the given message to the console' do
      stdout = TestStdout.new
      stdin = TestStdin.new
      console = Console.new(stdout:, stdin:)

      message = 'Hello World'

      console.output(message)

      expect(stdout.messages).to include(message)
    end
  end

  context '#gets_input' do
    it 'returns user input' do
      stdout = TestStdout.new
      stdin = TestStdin.new
      console = Console.new(stdout:, stdin:)

      expect(console.gets_input).to eq('user input')
    end
  end
end
