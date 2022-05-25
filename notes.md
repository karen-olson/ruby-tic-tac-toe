### Classes

# GameStarter

- Responsible for running configuration and starting the loop
- Knows 

# GameLoop

- Responsible for the control flow of the game
- Knows 

# Player

- Responsible for selecting a token
- Responsible for selecting spaces
- Knows 

# Board

- Responsible for managing its own state
    - mark_space
    - get_space
- Knows 

# Console

- Responsible for interacting with the user through the console
    - output(message)
    - get_input
- Knows

# Display

- Responsible for displaying the board in a specific format
- Knows 

# Prompt

- Responsible for prompting the user until it receives valid input
- Knows 

# NumberValidator

- Responsible for determining whether a number is an integer within a given range
- Knows 




### Messages

# Starting the game
- Send this message from the terminal (ruby bin/run)

# Choosing a token to start (?) --> Not doing this right now. 

# Displaying the board
- GameLoop sends this message to Display (how does Display know what the current Board values are?)
    - Is Board passed in as an object?
    - Is Board a value object and GameLoop calls Board.get_board or something? (read about value objects)

# Displaying prompts to the user
- "happy path" prompts
    - Prompt sends these messages to Console

# Displaying error messages to the user
- "sad path"?? prompts
    - Prompt sends these messages to Console

# Continuing the game until a condition is met
- GameLoop sends a message to ______ to get the state of the board
- Who evaluates whether a game-ending condition has been met? 
    - Probably GameLoop since it's responsible for the control flow

# Knowing the game-ending conditions (data, not behavior)
- Who knows what the game-ending conditions are? 
    - Should it be Board?
        - No, a Board doesn't know things
    - Should it be Game?
        - Maybe? When Game is configured, the rules can be set there
        - What does it look like to configure the game setup? (all of this will happen later on)
            - Choose starting tokens
            - Human v Human or AI? 
            - Game rules
    - Should it be GameLoop? 
        - Maybe? But it seems like knowing the conditions might be someone else's job, and GameLoop
            might just evaluate the board based on the conditions rather than knowing what they are.
            But sending that extra message between Game and GameLoop might not be ideal? Why not? 
    - Should it be its own class?
        - ConditionChecker? No bc GameLoop does the checking
        - BoardEvaluator? No bc same thing
        - WinningCombo? No bc it doesn't have behavior, just data
        - No. 

# Getting user input
- Anyone can send this message to Console

# Validating that user input is a valid number
- Prompt sends this message to NumberValidator

# Validating that user's desired space isn't already taken
- _____ sends this message to ________Validator ?

# Marking the board
- _____ sends this message to Board

# Getting the state of the board
- _____ sends this message to Board (get_space, get_rows, get_columns, get_diagonals (?))

# Taking turns
- GameLoop sends this message to self

# Tracking whose turn it is
- GameLoop sends this message to _____

# Determining when the board is full
- GameLoop sends this message to ____

# Determining when there is a win
- GameLoop sends this message to ____

# Determining when there is a tie
- GameLoop sends this message to ____

# Displaying the results
- ______ sends this message to Console

# Watching for a user to enter CTRL + D or CTRL + C
- GameLoop sends this message to _____

# Exiting the program with CTRL + D
- ________ sends this message to ____

# Exiting the program with CTRL + C
- ________ sends this message to ____