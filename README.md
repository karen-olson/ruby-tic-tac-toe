<h1 align=“center”>Tic Tac Toe</h1>
This Tic Tac Toe game is a command line application built in Ruby.
The initial functionality permits gameplay between two human players. The program will exit when gameplay ends: either when a player has won, or if the game has reached a draw.
## Table of Contents
- [Getting Started](#getting_started)
    - [Installation](#installation)
    - [Linting](#linting)
    - [Testing](#testing)
- [Usage](#usage)
    - [Launching the Game](#launching)
    - [Instructions](#instructions)
- [Future Implementation](#future)
<br><br>
## Getting Started <a name = “getting_started”></a>
### Installation <a name = “installation”></a>
Clone this repo from the terminal:
```
git clone https://github.com/fifikim/tictactoe.git
```
cd to the program directory & install dependencies:
```
bundle install
```
### Linting <a name = “linting”></a>
Run the linter:
```
bundle exec rubocop
```
To safely autocorrect correctable offenses:
```
bundle exec rubocop -a
```
### Testing <a name = “testing”></a>
Run tests:
```
bundle exec rspec
```
To automate the test suite:
```
bundle exec guard init rspec
bundle exec guard
```
<br>
## Usage <a name=“usage”></a>
### Launch the program <a name = “launching”></a>
From program directory:
```
ruby tictactoe.sh
```
### Instructions
Enter the number (1-9) of the space on the board where you want to move.
Player 1 moves first and marks their spaces with an “X”. Player 2 marks with an “O”.
To win, claim 3 adjacent spaces in a horizontal, vertical, or diagonal line.
If there are no free spaces and no player has won, the game will end in a draw.
<br>
## Future Implementation <a name = “future”></a>
- Add gameplay between a human player vs. AI player
- Allow user to select the order of players
<br><br>