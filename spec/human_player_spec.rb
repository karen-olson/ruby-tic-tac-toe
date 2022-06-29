require 'human_player'

describe 'Human Player' do
    describe '#marker' do
        it 'returns the correct marker' do
            class TestUIforHumanPlayer
                def get_selection
                    '1'
                end
            end

            ui = TestUIforHumanPlayer.new
            player = HumanPlayer.new(marker: 'X', ui:)

            expect(player.marker).to eq('X')
        end
    end

    describe '#select_space' do
        it "returns the human player's selected space" do
            ui = TestUIforHumanPlayer.new
            player = HumanPlayer.new(marker: 'X', ui:)

            space = player.select_space

            expect(space).to eq('1')
        end
    end
end