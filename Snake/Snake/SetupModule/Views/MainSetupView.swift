//
//  MainSetupView.swift
//  Snake
//
//  Created by Natalia Pashkova on 14.01.2024.
//

import UIKit

class MainSetupView: UIView {
    
    private var levelButtonStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLevelButtonStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLevelButtonStack() {
        let easyButton = LevelButton(text: "8 x 8")
        let normalButton = LevelButton(text: "10 x 10")
        let hardButton = LevelButton(text: "12 x 12")
        
        levelButtonStack = UIStackView(arrangedSubviews: [easyButton, normalButton, hardButton])
        
        levelButtonStack.arrangedSubviews.enumerated().forEach{$0.element.tag = $0.offset}
        
        levelButtonStack.axis = .vertical
        levelButtonStack.spacing = 5
        levelButtonStack.distribution = .fillEqually
        levelButtonStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(levelButtonStack)
        NSLayoutConstraint.activate([
            levelButtonStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            levelButtonStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            levelButtonStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            levelButtonStack.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
}
