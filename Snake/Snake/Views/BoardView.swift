//
//  BoardView.swift
//  Snake
//
//  Created by Natalia Pashkova on 05.04.2023.
//

import UIKit

class BoardView: UIView {
    
    private let originX : CGFloat = 0
    private let originY : CGFloat = 0
    private var cellSize: CGFloat = 0
    
    var snake: SnakeModel?
    var addPoint: AddPointModel?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellSize = frame.width / CGFloat(GameModel.cols)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawGrid ()
        drawAddPoint()
        drawSnake()
    }
    
    private func drawGrid () {
        
        let gridPath = UIBezierPath()
        
        for i in 0...GameModel.rows {
            gridPath.move(to: CGPoint(x: originX, y: originY + CGFloat(i) * cellSize))
            gridPath.addLine(to: CGPoint(x: originX + CGFloat(GameModel.cols) * cellSize, y: originY + CGFloat(i) * cellSize))
        }
        
        for i in 0...GameModel.cols {
            gridPath.move(to: CGPoint(x: originX + CGFloat(i) * cellSize, y: originY))
            gridPath.addLine(to: CGPoint(x: originX + CGFloat(i) * cellSize, y: originY + CGFloat(GameModel.rows) * cellSize))
        }
        
        let rect = CGRect(x: 0, y: 0, width: 256, height: 256)
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: 50)
        let circle = UIBezierPath(ovalIn: rect)
        
        SnakeColor.grid.setStroke()
        gridPath.stroke()
    }
    
    private func drawSnake() {
        guard let snake, !snake.snake.isEmpty, let head = snake.snake.first else { return }
        
        SnakeColor.snakeHead.setFill()
        UIBezierPath(
            roundedRect: CGRect(
                x: originX + CGFloat(head.col) * cellSize,
                y: originY + CGFloat(head.row) * cellSize,
                width: cellSize,
                height: cellSize),
            cornerRadius: 5).fill()
        
        SnakeColor.snakeBody.setFill()
        for i in 1..<snake.snake.count {
            let cell = snake.snake[i]
            UIBezierPath(
                roundedRect: CGRect(
                    x: originX + CGFloat(cell.col) * cellSize,
                    y: originY + CGFloat(cell.row) * cellSize,
                    width: cellSize,
                    height: cellSize),
                cornerRadius: 5).fill()
        }
    }
    
    private func drawAddPoint() {
        guard let addPoint else { return }
        SnakeColor.foodPoint.setFill()
        UIBezierPath(
            roundedRect: CGRect(
                x: originX + CGFloat(addPoint.coordinate.col) * cellSize,
                y: originY + CGFloat(addPoint.coordinate.row) * cellSize,
                width: cellSize,
                height: cellSize),
            cornerRadius: 5).fill()
    }
}
