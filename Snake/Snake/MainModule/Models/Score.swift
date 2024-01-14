//
//  Score.swift
//  Snake
//
//  Created by Natalia Pashkova on 14.01.2024.
//

import Foundation

class Score {
    
    private var score = 0
    private var next: Int
    
    var amount: Int {
        score
    }
    
    var toNextLevel: Int {
        score % next == 0 ? next : next - score % next
    }
    
    init(next: Int) {
        self.next = next
    }
    
    func addScore() -> Bool {
        score += 1
        return score % next == 0 && score != 0
    }
    
}
