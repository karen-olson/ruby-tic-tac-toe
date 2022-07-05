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


## Potential Refactorings

### Number Validator

- Initialize with a range instead of passing the range in to valid?

### Prompt

- Remove @valid input from initialize
- Remove range
- Put console.output and console.gets_input into private helper method
- Change implementation like in last PR so number validation and availability validation are separated, and a separate error message is displayed for each case. 


## Random Number Refactoring Notes

### Overview

- Goal: Change `RandomNumberGenerator` so it can either be predictable or random.

- Purpose: To make testing possible while keeping the computer player's
  selections truly random in the game environment. 

### Steps

- Write a test for `RandomNumberGenerator` that takes in a stubbed `rand` method. The
  stubbed method has the same structure as rand but returns a predictable value. Assert that the stubbed method is returning the correct value. 
  - Don't test Ruby's built-in random functionality. Trust that it works, and just assert
    that your program is using it correctly. 

- In bin/run, create a new instance of Ruby's `Random` object.

  `random = Random.new(ENV["SEED"].to_i || Random.new_seed)`

  The new `Random` instance is created either with a seed that you specify in an environment variable when you run the program (`ENV['SEED'].to_i`), or a random seed (`Random.new_seed`). If you specify a seed when you run the program, the `RandomNumberGenerator` will be predictable. If you don't specify a seed, it will be random. 

- Have `RandomNumberGenerator` take in a `rand` method as a parameter so you can
  control whether it returns predictable or random numbers. 

- In bin/run, create a variable to hold your desired `rand` method (as a lambda). 
  This method comes from whichever random object you just created. So if you created an instance of `Random` with a specified seed, your `rand` function will return predictable output. If you created an instance of `Random` with a random seed, your `rand` function will return random output. 

- Feed the `rand` function to the `RandomNumberGenerator`, and invoke it with `.call`
  to return a random (or not random) number. 

- Change the acceptance spec so that ruby bin/run is invoked with a `SEED` environment
  variable. This way, the computer player's selections will be predictable for testing. 