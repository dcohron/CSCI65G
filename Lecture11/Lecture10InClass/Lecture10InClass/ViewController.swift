//
//  ViewController.swift
//  Lecture10InClass
//
//  Created by Van Simmons on 7/25/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fetch(sender: AnyObject) {
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=boston,%20ma&appid=77e555f36584bc0c3d55e1e584960580")!
        let fetcher = Fetcher()
        fetcher.requestJSON(url) { (json, message) in
            let op = NSBlockOperation {
                if let json = json {
                    self.textView.text = json.description
                }
                else if let message = message {
                    self.textView.text = message
                }
                else {
                    self.textView.text = "WTF?"
                }
            }
            NSOperationQueue.mainQueue().addOperation(op)
        }
    }
}

