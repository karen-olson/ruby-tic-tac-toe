require 'availability_validator'

describe 'Availability Validator' do
    context '#available?' do
        it 'determines whether a space on the board is available' do
            board = TestBoard.new
            allow(board).to receive(:values).and_return(['X', 2, 3, 4, 5, 6, 7, 8, 9])
            
            availability_validator = AvailabilityValidator.new(board: board)

            first_space_availability = availability_validator.available?(1)
            second_space_availability = availability_validator.available?(2)

            expect(first_space_availability).to eq(false)
            expect(second_space_availability).to eq(true)
        end
    end
end