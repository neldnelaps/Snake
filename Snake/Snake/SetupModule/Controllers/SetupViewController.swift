//
//  SetupViewController.swift
//  Snake
//
//  Created by Natalia Pashkova on 14.01.2024.
//

import UIKit

class SetupViewController: UIViewController {
    
    private var mainSetupView: MainSetupView? {
        view as? MainSetupView
    }
    
    override func loadView() {
        self.view = MainSetupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    @objc func levelButtonTapped(sender: UIButton) {
        var gameDelails = GameDetails(cols: 0, rows: 0, toNextLevel: 0)
        
        switch sender.tag {
        case 0:
            gameDelails = GameDetails(cols: 8, rows: 8, toNextLevel: 10)
        case 1:
            gameDelails = GameDetails(cols: 10, rows: 14, toNextLevel: 3)
        case 2:
            gameDelails = GameDetails(cols: 12, rows: 18, toNextLevel: 10)
        default:
            print("error level button")
        }
        
        let mainViewController = MainViewController(gameDetails: gameDelails)
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true)
    }
    
}
