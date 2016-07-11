//
//  ViewController.swift
//  Lecture6
//
//  Created by David Cohron on 7/11/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ExampleDelegateProtocol {
    
    // This just assures that example will conform with ExampleProtocol
    //  Even though we do not know what class it is
    //  AND can have no more than the protocol
    //  Therefore provides upper and lower bound
    
    var example: ExampleProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        example = Example()
        example.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func example(example: Example, didUpdateRows modelRows: UInt) {
        Rows.text = String(modelRows)
    }
    
    @IBOutlet weak var Rows: UITextField!

    @IBAction func increment(sender: AnyObject) {
        example.rows += 10
    }
    
}

