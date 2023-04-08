//
//  ViewController.swift
//  Snake
//
//  Created by Natalia Pashkova on 05.04.2023.
//

import UIKit

class ViewController: UIViewController {

    private let boardView = BoardView()
    
    private let joystickView = JoystickView()
    private var gameModel = GameModel()
    private let snakeModel = SnakeModel()
    private let addPointModel = AddPointModel()
    
    private var timer = Timer()
    
    private var direction : MovingDirection = .left
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        addSwipe()
        startTimer()
    }

    private func setupViews() {
        view.backgroundColor = UIColor.white
        gameModel = GameModel(snake: snakeModel, addPoint: addPointModel)
        joystickView.joystickDelegate = self
        
        view.addSubview(boardView)
        view.addSubview(joystickView)
    }
    
    // MARK: UISwipeGestureRecognizer
    
    private func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .right, .up, .down]
        directions.forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            swipe.direction = $0
            boardView.addGestureRecognizer(swipe)
        }
    }

    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left: direction = .left
        case .right: direction = .right
        case .up: direction = .up
        case .down: direction = .down
        default:
            break
        }
    }
    
    // MARK: Timer
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.3,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func timerAction () {
        gameModel.checkEating()
        snakeModel.checkDirection(direction)
        snakeModel.moveSnake()
        
        if !gameModel.isOnBoard() || !gameModel.crashTest() {
            timer.invalidate()
        }
            
        updateUI()
    }
    
    private func updateUI() {
        boardView.snake = snakeModel
        boardView.addPoint = addPointModel
        boardView.setNeedsDisplay()
    }
}

// MARK: Set Constraints

extension ViewController {
    private func setConstraints () {
        NSLayoutConstraint.activate([
            boardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            boardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            boardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor, constant: 1),
            
            joystickView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            joystickView.heightAnchor.constraint(equalToConstant: 100),
            joystickView.widthAnchor.constraint(equalToConstant: 100),
            joystickView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: JoystickProtocol

extension ViewController : JoystickProtocol {
    func changeDirection(_ direction: MovingDirection) {
        self.direction = direction
    }
}
