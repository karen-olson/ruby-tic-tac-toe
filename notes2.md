### Note about Setting Up Test Doubles

For the TestNumberValidatorForRepeatedInput double in `prompt_spec` it would be more descriptive for other readers
if the logic of the test double was made clear in the Setup step of the test. 

Test double logic:
- Make the input valid after 1 attempt

One idea:
- Name the test double something like SucceedsAfter.new(attempts: 1)
- The inner workings of the test double can be similar, but the naming and the given parameter
    make the purpose of the test double super clear. 

### Spiking Different Outcome Checker API

- Difficult to do in an "ask" way, while making it meaningfully different than what I have already
- Here's an example of the beginning of TDD-ing a "tell" version

  describe '#outcome' do
    context 'when the game is in progress' do
      it 'it calls the in_progress block argument' do
        outcome_checker = OutcomeChecker.new(board:)

        class Spy
          attr_reader :called
          def initialize
            @called
          end

          def call
            @called = true
          end
        end

        in_progress = Spy.new
        outcome_checker.on_outcome(in_progress: in_progress)

        expect(in_progress.called).to be(true)
        expect(winner.called).to be(false)

        expect(spy).to only_have_called(:in_progress)
      end
    end
  end

  - After making this test pass, add another, similar test to make sure it calls the "win" block arg when there's a win.
  - At that point, go back and add line 27 to flesh out the first test. 
  - Could add line 29 to make a set of related expect statements into a custom matcher so that it's clear what you're doing, but that's also a lot more effort
    than just putting a few related expect statements next to each other. 