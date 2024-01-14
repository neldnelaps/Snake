//
//  GameField.swift
//  Snake
//
//  Created by Natalia Pashkova on 13.01.2024.
//

import Foundation

class GameField {
    private var sizeField: GameCell
    var size: GameCell {
        sizeField
    }
    
    init(cols: Int, rows: Int) {
        sizeField = GameCell(col: cols, row: rows)
    }
}
