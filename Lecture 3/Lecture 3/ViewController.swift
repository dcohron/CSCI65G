//
//  ViewController.swift
//  Lecture 3
//
//  Created by David Cohron on 6/27/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonClicked(sender: AnyObject) {
        print("We were clicked")
    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

