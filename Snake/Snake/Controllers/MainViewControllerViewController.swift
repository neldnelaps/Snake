//
//  ViewController.swift
//  Snake
//
//  Created by Natalia Pashkova on 05.04.2023.
//

import UIKit

class MainViewController: UIViewController {

    private var mainView : MainView{
        view as! MainView
    }
    private var gameModel = GameModel()
    private let snakeModel = SnakeModel()
    private let addPointModel = AddPointModel()
    private let controlModel = ControlModel()
    private let gameTimer = GameTimer()
    
    override func loadView() {
        super.loadView()
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameModel = GameModel(snake: snakeModel, addPoint: addPointModel)
        setDelegates()
        gameTimer.startTimer()
    }

    private func setDelegates() {
        mainView.joystickView.joystickDelegate = self
        mainView.boardView.boardDelegate = self
        gameTimer.timerDelegate = self
    }
    
    private func updateUI() {
        mainView.boardView.snake = snakeModel.snake
        mainView.boardView.addPoint = CGPoint(x: addPointModel.coordinate.col, y: addPointModel.coordinate.row)
        
        mainView.scoreLabel.text = gameModel.gameScore.score
        mainView.nextLevelLabel.text = gameModel.gameScore.nextLevel
        
        mainView.boardView.setNeedsDisplay()
    }
}

// MARK: TimerProtocol

extension MainViewController : TimerProtocol {
    func timerAction() {
        snakeModel.checkDirection(controlModel.direction)
        snakeModel.moveSnake()
        
        if gameModel.checkNextLevel() {
            gameTimer.speedIncrease()
        }

        if !gameModel.isOnBoard() || !gameModel.crashTest() {
            gameTimer.stopTimer()
        }

        updateUI()
    }
    

}

// MARK: JoystickProtocol

extension MainViewController : JoystickProtocol {
    func changePointLocation(_ point: CGPoint) {
        controlModel.changeDirection(point)
    }
}

// MARK: BoardProtocol

extension MainViewController : BoardProtocol {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .left: controlModel.direction = .left
        case .right: controlModel.direction = .right
        case .up: controlModel.direction = .up
        case .down: controlModel.direction = .down
        default:
            break
        }
    }
}
