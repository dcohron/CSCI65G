//
//  ViewController.swift
//  Assignment3
//
//  Created by David Cohron on 7/8/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set title for navigation bar
        self.navigationItem.title = "Life Game";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func RunNextGen(sender: AnyObject) {
//        var nextGrid:[[CellState]] = [[]]
        
        // Call function step to generate next generation grid based upon game rules
        //  Call generates compile error so is commented out
//        var nextGrid = step(grid)
        
    }

}

