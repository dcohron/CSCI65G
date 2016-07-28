//
//  SampleTimer.swift
//  SampleTimer
//
//  Created by Jp LaFond on 7/25/16.
//  Copyright © 2016 Jp4Mobile. All rights reserved.
//

import Foundation

/// closure used by the timer
typealias TimerClosure = (()->Void)

/// Sample Timer class
class SampleTimer {
    /// The timer in the class
    private var timer : NSTimer?
    private var storedTimerClosure : TimerClosure?

    /// Cancel the timer
    func cancelTimer() {
        print("Canceling")
        timer?.invalidate()
        timer = nil
    }

    /// Start timer
    func startTimer(delay: Double,
                    trailingClosure : TimerClosure? = nil) {
        // Invalidate any old one in case it was called more than once
        timer?.invalidate()
        // Set up the timer
        timer = NSTimer.scheduledTimerWithTimeInterval(delay,
                                                       target: self,
                                                       selector: #selector(timerTriggered),
                                                       userInfo: nil,
                                                       repeats: true)

        timer = NSTimer(timeInterval: delay,
                        target: self,
                        selector: #selector(timerTriggered),
                        userInfo: nil,
                        repeats: true)
        // Safe the closure, if present
        if let trailingClosure = trailingClosure {
            storedTimerClosure = trailingClosure
        } else {
            // clear it out otherwise
            storedTimerClosure = nil
        }
    }

    /// Private function triggered by the timer
    // NOTE: Private does nothing in a playground
    @objc private func timerTriggered(timer: NSTimer) {
        // We need to set the class variable to the new instance, otherwise, we cannot actually cancel it
        self.timer = timer
        print ("Timer triggered <\(timer.fireDate)>")
        if let savedClosure = storedTimerClosure {
            // Call the actual closure
            savedClosure()
        } else {
            print("No closure to call")
        }
    }
}