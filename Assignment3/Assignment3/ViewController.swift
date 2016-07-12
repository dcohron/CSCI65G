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
    
    @IBOutlet weak var GridPane: GridView!
    
    
    //    Problem 6
    @IBAction func RunNextGen(sender: AnyObject) {
        
        // initialize new generation with random seeding
        for x in 0..<grid.count {
            for y in 0..<grid.count {
                if arc4random_uniform(3) == 1 {
                    grid[x][y] = .Living
                }
                else {
                    grid[x][y] = .Empty
                }
            }
        }

        GridPane.setNeedsDisplay()
        
    }
}

    
