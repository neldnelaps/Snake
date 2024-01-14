//
//  SnakeBoard.swift
//  Snake
//
//  Created by Natalia Pashkova on 05.04.2023.
//

import Foundation

class GameModel {

    private var gameDelails: GameDetails
    private var score: Score
    private var snake = Snake()
    private var addPoint = AddPoint()
    private let gameTimer = GameTimer()
    
    private weak var viewController: MainViewController?
    
    init(vc: MainViewController, gameDelails: GameDetails) {
        self.gameDelails = gameDelails
        self.score = Score(next: gameDelails.toNextLevel)
        viewController = vc
        gameTimer.timerDelegate = self
        gameTimer.startTimer()
        vc.updateAddPoint(addPoint.coordinate)
    }
    
    // MARK: Game Actions
    
    func changeDirection(_ direction: MovingDirection) {
        snake.checkDirection(direction)
    }
 
    private func checkEating () {
        if snake.snake[0] == addPoint.coordinate {
            snake.eatAddPoint()
            addPoint.randomizeFoodPoint(snake: snake.snake, cols: gameDelails.cols, rows: gameDelails.rows)
            
            if score.addScore() {
                gameTimer.speedIncrease()
            }
            viewController?.updateScoreLabels(score: score.amount, to: score.toNextLevel)
            viewController?.updateAddPoint(addPoint.coordinate)
        }
    }
    
    func isOnBoard() {
        if snake.snake[0].row < 0 || snake.snake[0].row > gameDelails.rows - 1 ||
            snake.snake[0].col < 0 || snake.snake[0].col > gameDelails.cols - 1 {
            gameTimer.stopTimer()
        }
    }
}

// MARK: TimerProtocol

extension GameModel: TimerProtocol {
    func timerAction() {
        snake.moveSnake()
        checkEating()
        isOnBoard()
        if snake.crashTest() {
            gameTimer.stopTimer()
        }
        viewController?.updateSnake(snake.snake)
    }
}
