//
//  SecondViewController.swift
//  Class11A- my build
//
//  Created by David Cohron on 7/27/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func notifiedFromSecond(sender: AnyObject) {
        let userInfo = ["message": "This came from Second"]
        let notification = NSNotification(name: "FromSecond", object: self, userInfo: userInfo)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    
    @IBOutlet weak var notifiedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(notifyFromFirst(_:)), name: "FromFirst", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func notifyFromFirst(notification:NSNotification) {
        notifiedLabel.text = (notification.userInfo!["message"] as! String)
    }

    
}

