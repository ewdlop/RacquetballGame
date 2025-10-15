# RacquetballGame

A simple text-based racquetball game simulator written in [Racket](https://racket-lang.org/).

## About

This project simulates a racquetball game between two players. The game follows basic racquetball rules:
- First player to reach 15 points wins
- Must win by at least 2 points
- Only the serving player can score points
- When a non-serving player wins a rally, they become the server

## Requirements

- [Racket](https://racket-lang.org/) programming language (version 8.0 or higher recommended)

## Installation

1. Install Racket from [https://racket-lang.org/](https://racket-lang.org/)
2. Clone this repository:
   ```bash
   git clone https://github.com/ewdlop/RacquetballGame.git
   cd RacquetballGame
   ```

## Usage

Run the game using the Racket interpreter:

```bash
racket racquetball.rkt
```

The game will automatically simulate rallies and display the results until one player wins.

## Game Features

- Automatic rally simulation with realistic probabilities
- Score tracking for both players
- Server tracking (indicated by [SERVING] marker)
- Win condition checking (15 points with 2-point margin)
- Rally-by-rally commentary

## Example Output

```
=====================================
     RACQUETBALL GAME SIMULATOR
=====================================

Game starting... First to 15 points wins!
(Must win by at least 2 points)
-------------------------------------
Player 1: 0 points [SERVING]
Player 2: 0 points
-------------------------------------

Rally #1: Player 1 wins the rally!
-------------------------------------
Player 1: 1 points [SERVING]
Player 2: 0 points
-------------------------------------
...
```

## License

This project is open source and available for educational purposes.