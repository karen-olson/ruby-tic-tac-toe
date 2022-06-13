require 'pry'

class Console
  def initialize(stdout: $stdout, stdin: $stdin)
    @stdout = stdout
    @stdin = stdin
  end

  def output(message)
    stdout.puts message
  end

  def gets_input
    stdin.gets.chomp
  end

  private

  attr_reader :stdout, :stdin
end
