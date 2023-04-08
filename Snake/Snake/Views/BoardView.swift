//
//  BoardView.swift
//  Snake
//
//  Created by Natalia Pashkova on 05.04.2023.
//

import UIKit

protocol BoardProtocol : AnyObject {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction)
}

class BoardView: UIView {
    
    weak var boardDelegate : BoardProtocol?
    
    private let originX : CGFloat = 0
    private let originY : CGFloat = 0
    private var cellSize: CGFloat = 0
    
    var snake: [SnakeCell]?
    var addPoint: CGPoint?
    
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
        addSwipe()
    }
    
// MARK: Drow object
    
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
        
        SnakeColor.grid.setStroke()
        gridPath.stroke()
    }
    
    private func drawSnake() {
        guard let snake, !snake.isEmpty, let head = snake.first else { return }
        
        SnakeColor.snakeHead.setFill()
        UIBezierPath(
            roundedRect: CGRect(
                x: originX + CGFloat(head.col) * cellSize,
                y: originY + CGFloat(head.row) * cellSize,
                width: cellSize,
                height: cellSize),
            cornerRadius: 5).fill()
        
        SnakeColor.snakeBody.setFill()
        for i in 1..<snake.count {
            let cell = snake[i]
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
                x: originX + addPoint.x * cellSize,
                y: originY + addPoint.y * cellSize,
                width: cellSize,
                height: cellSize),
            cornerRadius: 5).fill()
    }
    
// MARK: UISwipeGestureRecognizer
    
    private func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .right, .up, .down]
        directions.forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            swipe.direction = $0
            self.addGestureRecognizer(swipe)
        }
    }

    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        boardDelegate?.swipeGesture(direction: sender.direction)
    }
}
