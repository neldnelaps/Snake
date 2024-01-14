//
//  GameTimer.swift
//  Snake
//
//  Created by Natalia Pashkova on 09.04.2023.
//

import Foundation

protocol TimerProtocol : AnyObject {
    func timerAction ()
}

class GameTimer {
    
    private var timer = Timer()
    private var timerInterval = 0.3
    
    weak var timerDelegate : TimerProtocol?
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: timerInterval,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func timerAction () {
        timerDelegate?.timerAction()
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func speedIncrease () {
        if Float(timerInterval) > 0.2 {
            timerInterval -= 0.1
        }
        stopTimer()
        startTimer()
    }

}
