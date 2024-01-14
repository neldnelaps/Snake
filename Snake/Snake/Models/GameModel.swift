//
//  SnakeBoard.swift
//  Snake
//
//  Created by Natalia Pashkova on 05.04.2023.
//

import Foundation

class GameModel {

    private var gameField: GameField
    private var snake = Snake()
    private var addPoint = AddPoint()
    private let gameTimer = GameTimer()
    
    private weak var viewController: MainViewController?
    
    init(vc: MainViewController, cols: Int, rows: Int) {
        self.gameField = GameField(cols: cols, rows: rows)
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
            addPoint.randomizeFoodPoint(snake: snake.snake, gameCell: gameField.size)
            viewController?.updateAddPoint(addPoint.coordinate)
        }
    }
    
    func isOnBoard() {
        if snake.snake[0].row < 0 || snake.snake[0].row > gameField.size.row - 1 ||
            snake.snake[0].col < 0 || snake.snake[0].col > gameField.size.col - 1 {
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
