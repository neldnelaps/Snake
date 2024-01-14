//
//  AddPointModel.swift
//  Snake
//
//  Created by Natalia Pashkova on 06.04.2023.
//

import Foundation

class AddPoint {
    private var addPointCoordinate = GameCell(col: 1, row: 4)
    
    var coordinate: GameCell {
        addPointCoordinate
    }
    
    func randomizeFoodPoint(snake: [GameCell], cols: Int, rows: Int) {

        func isOnSnake() -> Bool {
            for cell in snake {
                if cell.col == addPointCoordinate.col && cell.row == addPointCoordinate.row {
                    return true
                }
            }
            return false
        }
        
        while isOnSnake() {
            addPointCoordinate.col = Int.random(in: 1..<cols)
            addPointCoordinate.row = Int.random(in: 1..<rows)
        }
    }
}
