#lang racket

;; Racquetball Game - A simple text-based racquetball simulation
;; Author: Racquetball Game Project
;; Description: Implements a basic racquetball game with scoring and rally simulation

;; Game constants
(define WINNING-SCORE 15)
(define MIN-WINNING-MARGIN 2)

;; Player structure
(struct player (name score serving?) #:transparent #:mutable)

;; Create two players
(define player1 (player "Player 1" 0 #t))
(define player2 (player "Player 2" 0 #f))

;; Display game banner
(define (display-banner)
  (displayln "")
  (displayln "=====================================")
  (displayln "     RACQUETBALL GAME SIMULATOR")
  (displayln "=====================================")
  (displayln ""))

;; Display current score
(define (display-score p1 p2)
  (displayln "-------------------------------------")
  (printf "~a: ~a points~a~n" 
          (player-name p1) 
          (player-score p1)
          (if (player-serving? p1) " [SERVING]" ""))
  (printf "~a: ~a points~a~n" 
          (player-name p2) 
          (player-score p2)
          (if (player-serving? p2) " [SERVING]" ""))
  (displayln "-------------------------------------"))

;; Simulate a rally - returns #t if server wins, #f otherwise
(define (simulate-rally)
  ;; Simple probability model: 55% chance server wins rally
  (< (random) 0.55))

;; Check if game is over
(define (game-over? p1 p2)
  (let ([score1 (player-score p1)]
        [score2 (player-score p2)])
    (and (or (>= score1 WINNING-SCORE) 
             (>= score2 WINNING-SCORE))
         (>= (abs (- score1 score2)) MIN-WINNING-MARGIN))))

;; Switch server
(define (switch-server! p1 p2)
  (set-player-serving?! p1 (not (player-serving? p1)))
  (set-player-serving?! p2 (not (player-serving? p2))))

;; Play a single rally
(define (play-rally! p1 p2 rally-number)
  (printf "~nRally #~a: " rally-number)
  (sleep 0.5) ; Pause for dramatic effect
  
  (let ([server-wins (simulate-rally)])
    (cond
      [(and (player-serving? p1) server-wins)
       (displayln "Player 1 wins the rally!")
       (set-player-score! p1 (+ (player-score p1) 1))]
      [(and (player-serving? p2) server-wins)
       (displayln "Player 2 wins the rally!")
       (set-player-score! p2 (+ (player-score p2) 1))]
      [(player-serving? p1)
       (displayln "Player 2 wins the rally!")
       (switch-server! p1 p2)]
      [else
       (displayln "Player 1 wins the rally!")
       (switch-server! p1 p2)])))

;; Play the complete game
(define (play-game!)
  (display-banner)
  (displayln "Game starting... First to 15 points wins!")
  (displayln "(Must win by at least 2 points)")
  (display-score player1 player2)
  
  (let loop ([rally-count 1])
    (play-rally! player1 player2 rally-count)
    (display-score player1 player2)
    
    (if (game-over? player1 player2)
        (announce-winner player1 player2)
        (loop (+ rally-count 1)))))

;; Announce the winner
(define (announce-winner p1 p2)
  (displayln "")
  (displayln "=====================================")
  (displayln "           GAME OVER!")
  (displayln "=====================================")
  (let ([winner (if (> (player-score p1) (player-score p2)) p1 p2)])
    (printf "~a WINS with ~a points!~n" 
            (player-name winner) 
            (player-score winner)))
  (displayln "=====================================")
  (displayln ""))

;; Reset the game
(define (reset-game!)
  (set-player-score! player1 0)
  (set-player-score! player2 0)
  (set-player-serving?! player1 #t)
  (set-player-serving?! player2 #f))

;; Main function
(define (main)
  (reset-game!)
  (play-game!))

;; Run the game
(main)
