//
//  ViewController.swift
//  Section05
//
//  Created by Van Simmons on 2/15/15.
//  Copyright (c) 2015 ComputeCycles, LLC. All rights reserved.
//

import UIKit
import Section05Views

let data = [
    ["label" : "Mon",   "value" : NSNumber(int:15)],
    ["label" : "Tues",  "value" : NSNumber(int:30)],
    ["label" : "Weds",  "value" : NSNumber(int:7)],
    ["label" : "Thurs", "value" : NSNumber(int:60)],
    ["label" : "Fri",   "value" : NSNumber(int:30)],
    ["label" : "Sat",   "value" : NSNumber(int:15)],
    ["label" : "Sun",   "value" : NSNumber(int:45)],
] as [[String:AnyObject]]

class GraphViewController: UIViewController {

    @IBOutlet var graph:GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.graph.data = data
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        for v in graph.subviews {
            v.removeFromSuperview()
        }
        graph.layer.sublayers = nil
        self.view.setNeedsLayout()
        self.graph.setNeedsDisplay()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

