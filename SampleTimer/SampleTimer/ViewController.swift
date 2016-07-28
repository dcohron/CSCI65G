//
//  ViewController.swift
//  SampleTimer
//
//  Created by Jp LaFond on 7/25/16.
//  Copyright © 2016 Jp4Mobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var timerOutlet: UILabel!
    
    
    var timer : SampleTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Set up the timer
        timer = SampleTimer()
        var counter = 10
        // Start the timer at this interval
        timer?.startTimer(0.1) {
            // With a closure that will be called repeatedly from the timer
            self.timerOutlet.text="Timer triggered! <\(counter)>"

            // Stop after 5 times
            counter -= 1
            if counter < 0 {
                self.timer?.cancelTimer()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

