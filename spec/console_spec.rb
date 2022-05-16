require 'console'

describe 'Console' do
    
    context '#output' do
        it 'prints the given message to the console' do
            console = Console.new

            message = 'Hello World'
            
            expect { console.output(message) }.to output("#{message}\n").to_stdout
        end
    end
end