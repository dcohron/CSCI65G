//
//  FirstViewController.swift
//  Class11A- my build
//
//  Created by David Cohron on 7/27/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

struct Notifications {
    static let kMessage = "message"
}

class FirstViewController: UIViewController {

    @IBAction func notifyFromFirst(sender: AnyObject) {
        let userInfo = [Notifications.kMessage:"This came from First"]
        let notification = NSNotification(name: "FromFirst", object: self, userInfo: userInfo)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
    @IBOutlet weak var notifiedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(notifyFromSecond(_:)), name: "FromSecond", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func notifyFromSecond(notification: NSNotification) {
        notifiedLabel.text = (notification.userInfo!["message"] as! String)
    }


}

