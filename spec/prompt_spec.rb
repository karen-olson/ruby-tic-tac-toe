require 'prompt'

describe 'Prompt' do
  context '#choose_a_space' do
    it 'it prints the desired prompt to the console' do
      prompt = Prompt.new

      choose_a_space = 'Choose a space. Enter 1-9:'

      expect(prompt.choose_a_space).to eq(choose_a_space)
    end
  end
end
