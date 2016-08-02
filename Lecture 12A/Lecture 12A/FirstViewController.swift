//
//  FirstViewController.swift
//  Lecture 12A
//
//  Created by David Cohron on 8/1/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func post(sender: AnyObject) {
        let nc = NSNotificationCenter.defaultCenter()
        let notification = NSNotification(name: "Watch", object: nil, userInfo: ["refreshInterval": 1.0])
        nc.postNotification(notification)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

