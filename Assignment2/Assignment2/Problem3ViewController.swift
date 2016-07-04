//
//  Problem3ViewController.swift
//  Assignment2
//
//  Created by David Cohron on 7/3/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class Problem3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set title for navigation bar
        self.navigationItem.title = "Problem 3";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func runProblem3(sender: AnyObject) {
        
        var count = 0
        var toPrint = ""
        
        //  Function to count lives in total array
        func totalCount(inputArray:[[Bool]]) -> Int {
            var lifeCount = 0
            for row in 0...9 {
                for column in 0...9 {
                    if inputArray[row][column] == true {
                        lifeCount += 1
                    }
                }
            }
            return lifeCount
        }

        
        // Main body of runProblem3
        
        // instantiate array of boolean arrays for before and after
        var before = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
        var after = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
        
        // initialize before array prior to use with random seeding
        for row in 0...9 {
            for column in 0...9 {
                if arc4random_uniform(3) == 1 {
                    before[row][column] = true
                }
                else {
                    before[row][column] = false
                }
            }
        }

        
        count = totalCount(before)
        toPrint = "Alive before = \(count)"
        outputProblem3.text = toPrint
       
        
        // Pass before to step() in Engine.swift to get next generation returned as an array
        after = step(before)
        
        count = totalCount(after)
        toPrint += " and the new generation has \(count) lives."
        outputProblem3.text = toPrint
    }
    
    
    @IBOutlet weak var outputProblem3: UITextView!
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
