//
//  SnakeModel.swift
//  Snake
//
//  Created by Natalia Pashkova on 06.04.2023.
//

import Foundation

class Snake {
    
    private var snakeArray = [SnakeCell(col: 0, row: 0),
                             SnakeCell(col: 0, row: 1)]
    var snake: [SnakeCell] { snakeArray }
    
    var movingDirection : MovingDirection = .right
    
    private func updateSnake(newHead: SnakeCell) {
        var newSnake : [SnakeCell] = []
        newSnake.append(newHead)
        
        for i in 0..<snakeArray.count - 1 {
            newSnake.append(snakeArray[i])
        }
        snakeArray = newSnake
    }
    
    func moveSnake() {
        switch movingDirection {
        case .left:
            updateSnake(newHead: SnakeCell(col: snakeArray[0].col - 1 , row: snakeArray[0].row))
        case .right:
            updateSnake(newHead: SnakeCell(col: snakeArray[0].col + 1 , row: snakeArray[0].row))
        case .up:
            updateSnake(newHead: SnakeCell(col: snakeArray[0].col , row: snakeArray[0].row - 1))
        case .down:
            updateSnake(newHead: SnakeCell(col: snakeArray[0].col , row: snakeArray[0].row + 1))
        }
    }
    
//    func eatAddPoint() {
//        let oldTail = snakeArray[snakeArray.count - 1]
//        snakeArray.append(oldTail)
//    }
    
    func checkDirection (_ direction: MovingDirection) {
        switch direction {
        case .left:
            if movingDirection != .right {
                movingDirection = .left
            }
        case .right:
            if movingDirection != .left {
                movingDirection = .right
            }
        case .up:
            if movingDirection != .down {
                movingDirection = .up
            }
        case .down:
            if movingDirection != .up {
                movingDirection = .down
            }
        }
    }

}
