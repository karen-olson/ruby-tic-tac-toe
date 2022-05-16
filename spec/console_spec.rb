require 'console'

describe 'Console' do
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
    
    context '#output' do
        it 'prints the given message to the console' do
            stdout = TestStdout.new
            console = Console.new(stdout)

            message = 'Hello World'

            console.output(message)
            
            # Not asserting that puts works, asserting that the integration of puts works
            # (i.e. that puts is called in console)
            expect(stdout.messages).to include(message)
        end
    end
end