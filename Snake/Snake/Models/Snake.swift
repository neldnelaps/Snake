//
//  SnakeModel.swift
//  Snake
//
//  Created by Natalia Pashkova on 06.04.2023.
//

import Foundation

class Snake {
    
    private var snakeArray = [GameCell(col: 0, row: 0),
                             GameCell(col: 0, row: 1)]
    private var movingDirection : MovingDirection = .right
    
    var snake: [GameCell] { snakeArray }
    
    func moveSnake() {
        var newHead = GameCell(col: 0, row: 0)
        
        switch movingDirection {
        case .left:
            newHead = GameCell(col: snakeArray[0].col - 1, row: snakeArray[0].row)
        case .right:
            newHead = GameCell(col: snakeArray[0].col + 1, row: snakeArray[0].row)
        case .up:
            newHead = GameCell(col: snakeArray[0].col, row: snakeArray[0].row - 1)
        case .down:
            newHead = GameCell(col: snakeArray[0].col, row: snakeArray[0].row + 1)
        }
        snakeArray.insert(newHead, at: 0)
        snakeArray.removeLast()
    }
    
    func eatAddPoint() {
        let oldTail = snakeArray[snakeArray.count - 1]
        snakeArray.append(oldTail)
    }
    
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
    
    func crashTest() -> Bool {
        let snakeWithoutHead = snakeArray.dropFirst()
        let head = snakeArray[0]
        return snakeWithoutHead.contains(where: { $0.col == head.col && $0.row == head.row })
    }
}
