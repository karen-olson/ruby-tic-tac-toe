class Console
  attr_reader :stdout, :stdin

  def initialize(stdout, stdin)
    @stdout = stdout
    @stdin = stdin
  end

  def output(message)
    stdout.puts message
  end

  def gets_input
    stdin.gets
  end
end
