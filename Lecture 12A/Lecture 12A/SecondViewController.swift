//
//  SecondViewController.swift
//  Lecture 12A
//
//  Created by David Cohron on 8/1/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var refreshInterval: Double = 0
    var timer:NSTimer?
    var count: Int = 0
    
    
    
    @IBOutlet weak var countBox: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(watchForIntervalUpdates(_:)), name: "Watch", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func watchForIntervalUpdates(notification: NSNotification) {
        print("\(notification)")
        refreshInterval = notification.userInfo!["refreshInterval"] as! Double
    }
    
    func onTimerFire(timer: NSTimer) {
        print("Timer Fired")
        count = count + 1
        countBox.text = String(count)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        print("View Will Appear")
    }

    
    override func viewDidAppear(animated: Bool) {
        print("View Did Appear")
        if refreshInterval>0 {
            timer = NSTimer.scheduledTimerWithTimeInterval(refreshInterval, target: self, selector: #selector(onTimerFire(_:)), userInfo: nil, repeats: true)
    
        }
    }

    
    override func viewWillDisappear(animated: Bool) {
        print("View Will Disappear")
        timer?.invalidate()
        timer=nil
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("View Did Disappear")
    }
}

