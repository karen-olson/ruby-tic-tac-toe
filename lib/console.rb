class Console
  def initialize(stdin: $stdin, stdout: $stdout)
    @stdin = stdin
    @stdout = stdout
  end
  
  def gets_input
    stdin.gets.chomp
  end

  def output(message)
    stdout.puts message
  end

  private

  attr_reader :stdin, :stdout
end
