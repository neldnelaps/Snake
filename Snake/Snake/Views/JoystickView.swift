//
//  JoystickView.swift
//  Snake
//
//  Created by Natalia Pashkova on 08.04.2023.
//

import Foundation
import UIKit

protocol JoystickProtocol: AnyObject {
    func changeDirection (_ direction: MovingDirection)
}

class JoystickView : UIView {
    
    weak var joystickDelegate : JoystickProtocol?
    
    private let triangleDown = [(x: -50.0, y: -50.0), (x: 0.0, y:0.0),(x: 50.0, y:-50.0)]
    private let triangleUp = [(x: -50.0, y: 50.0), (x: 0.0, y:0.0),(x: 50.0, y:50.0)]
    private let triangleLeft = [(x: -50.0, y: 50.0), (x: 0.0, y:0.0),(x: -50.0, y:-50.0)]
    private let triangleRight = [(x: 50.0, y: 50.0), (x: 0.0, y:0.0),(x: 50.0, y:-50.0)]
    
    private var direction : MovingDirection = .left
    
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
            let point = (x: Double(location.x - 50), y: Double(50 - location.y))
            
            let directionJoystick = defineDirection(point: point)
            
            if directionJoystick != direction {
                direction = directionJoystick
                joystickDelegate?.changeDirection(direction)
            }
        }
    }
    
    private func defineDirection(point: (x: Double, y: Double)) -> MovingDirection {
        if isPointInsideTriangle(point, triangleDown) {
            return .down
        }
        if isPointInsideTriangle(point, triangleUp) {
            return .up
        }
        if isPointInsideTriangle(point, triangleLeft) {
            return .left
        }
        if isPointInsideTriangle(point, triangleRight) {
            return .right
        }
        return direction
    }
    
    private func isPointInsideTriangle ( _ point: (x: Double, y: Double), _ triangle: [(x: Double, y: Double)]) ->Bool {
        let x1 = triangle[0].x, y1 = triangle[0].y
        let x2 = triangle[1].x, y2 = triangle[1].y
        let x3 = triangle[2].x, y3 = triangle[2].y
        let x = point.x, y = point.y
        
        let areaTriangle = abs((x1*(y2-y3) + x2*(y3-y1) + x3*(y1-y2))/2)
        
        let areaTriangleFirst = abs((x1*(y2-y) + x2*(y3-y) + x*(y1-y2))/2)
        let areaTriangleSecond = abs((x*(y2-y3) + x2*(y3-y) + x3*(y-y2))/2)
        let areaTriangleThird = abs((x1*(y-y3) + x*(y3-y1) + x3*(y1-y))/2)
        
        return areaTriangle == areaTriangleFirst + areaTriangleSecond + areaTriangleThird

    }
}
