//
//  JoystickView.swift
//  Snake
//
//  Created by Natalia Pashkova on 08.04.2023.
//

import Foundation
import UIKit

protocol JoystickProtocol: AnyObject {
    func changePointLocation (_ point: CGPoint)
}

class JoystickView : UIView {
    
    weak var joystickDelegate : JoystickProtocol?
    
    private let centerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = SnakeColor.snakeHead
        layer.cornerRadius = 50
        translatesAutoresizingMaskIntoConstraints = false
        
        centerView.layer.cornerRadius = 50
        centerView.backgroundColor = .black
        centerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        addSubview(centerView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        getDirectionByTouches(touches: touches)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        getDirectionByTouches(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        centerView.frame.origin = CGPoint(x: 0, y: 0)
    }
    
    //    (-50,50)
    //    ⠀⠀⠀⢰⣶⣶⡶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⢶⣶⣶ (50,50)⠀⠀⠀
    //    ⠀⠀⠀⢸⡿⠿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣾⠿⢹⠀⠀⠀⠀
    //    ⠀⠀⠀⢸⡇⠀⠉⢿⣿⡤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣿⠿⠈⠀⢸⠀⠀⠀⠀
    //    ⠀⠀⠀⢸⡇⠀⠀⠀⠙⢻⣯⡄     ⠀⣠⣾⡟⠀⠀⠀ ⢸⠀⠀⠀⠀
    //    ⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠘⢻⣧(0,0)⣾⡟ ⠀⠀⠀⠀⢸⠀
    //        ⡇     ⠀⠀⠀ ⢿⣶⣾⠿⠋⠀⠀⠀⠀⠀⠀ ⢸⠀⠀⠀⠀
    //    ⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀  ⣾⠿⢿⣶⡀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀
    //    ⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⢠⣼⡿⠏⠀⠀⠙⢿⣧⡄⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀
    //    ⠀⠀⠀⢸⡇⠀⠀⠀⣠⣴⡟⠃⠁⠀⠀⠀⠀⠀⠙⢿⣧⡄⠀⠀⠀⢸⠀⠀⠀⠀
    //    ⠀⠀⠀⢸⡇⠀⣀⣾⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⣿⣶⣀⠀⢸⠀⠀⠀⠀
    //    ⠀⠀⠀⢸⣇⣶⣿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⣿⣦⣸⠀⠀⠀⠀
    //(-50,-50)⢸⣿⣿⣷⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣾(50,-50)⠀
    private func getDirectionByTouches(touches: Set<UITouch>) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            print(location)
            if bounds.contains(location) {
                centerView.center = location
            }
            let point = CGPoint(x: location.x - 50, y: 50 - location.y)
            
            joystickDelegate?.changePointLocation(point)

        }
    }
}
