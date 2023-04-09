//
//  MainView.swift
//  Snake
//
//  Created by Natalia Pashkova on 08.04.2023.
//

import Foundation
import UIKit

class MainView : UIView {
    
    let boardView = BoardView()
    let joystickView = JoystickView()
    
    let scoreLabel = UILabel()
    let nextLevelLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        configureBoardView()
        configureJoystickView()
        configureScoreLabel()
        configureNextLevelLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBoardView() {
        addSubview(boardView)
        NSLayoutConstraint.activate([
            boardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            boardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            boardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor, constant: 1)
        ])
    }
    
    private func configureJoystickView() {
        addSubview(joystickView)
        NSLayoutConstraint.activate([
            joystickView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -200),
            joystickView.heightAnchor.constraint(equalToConstant: 100),
            joystickView.widthAnchor.constraint(equalToConstant: 100),
            joystickView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureScoreLabel() {
        scoreLabel.text = "Score: 10"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 10),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    private func configureNextLevelLabel() {
        nextLevelLabel.text = "Next Level: 10"
        nextLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nextLevelLabel)
        NSLayoutConstraint.activate([
            nextLevelLabel.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 10),
            nextLevelLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
}
