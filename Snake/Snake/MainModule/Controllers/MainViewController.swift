//
//  ViewController.swift
//  Snake
//
//  Created by Natalia Pashkova on 05.04.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var gameModel : GameModel?
    private let gameDetails : GameDetails
    
    private var mainView : MainView? {
        view as? MainView
    }
    
    override func loadView() {
        self.view = MainView(gameDetails: gameDetails)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameModel = GameModel(vc: self, gameDelails: gameDetails)
        mainView?.boardDelegate = self
        mainView?.updateScoreLabels(score: 0, to: gameDetails.toNextLevel)
    }
    
    init(gameDetails: GameDetails) {
        self.gameDetails = gameDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSnake(_ snake: [GameCell]) {
        let boardView = mainView?.subviews[0] as? BoardView
        boardView?.snake = snake
    }
    
    func updateAddPoint(_ addPoint: GameCell) {
        let boardView = mainView?.subviews[0] as? BoardView
        boardView?.addPoint = CGPoint(x: addPoint.col, y: addPoint.row)
    }
    
    func updateScoreLabels(score: Int, to nextLabel: Int) {
        mainView?.updateScoreLabels(score: score, to: nextLabel)
    }
}

// MARK: BoardProtocol

extension MainViewController : BoardProtocol {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .left: gameModel?.changeDirection(.left)
        case .right: gameModel?.changeDirection(.right)
        case .up: gameModel?.changeDirection(.up)
        case .down: gameModel?.changeDirection(.down)
        default:
            break
        }
    }
}
