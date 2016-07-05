//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by David Cohron on 7/5/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class Problem2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // set title for navigation bar
        self.navigationItem.title = "Problem 2";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Action upon pressing the Run button
    
    @IBAction func runProblem2(sender: AnyObject) {
        
        // Initialize function variables
        
        var toPrint = ""
        var count = 0
        var neighborsAlive = 0
        var currentCell = false
        
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
        
        
        // instantiate array of boolean arrays named before and after
        var before = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
        var after = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
        
        
        // initialize array before use with random seeding
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
        
        // Count the initial lives based upon the random seeding and show in Text View
        
        count = totalCount(before)
        toPrint = "Alive before = \(count)."
        
        outputProblem2.text = toPrint
        
        
        // For each cell in array before, check number of neighbors that are alive and set state of array after
        
        for row in 0...9 {
            for column in 0...9 {
                
                // Function to count living cells in neigbors when passed array and subject cell row and column
                
                func hoodCount ( inputArray:[[Bool]], row:Int, column:Int) -> Int {
                    count = 0
                    if before[(row+1)%10][(column+9)%10] {count += 1}
                    if before[(row+1)%10][(column)%10] {count += 1}
                    if before[(row+1)%10][(column+1)%10] {count += 1}
                    if before[(row)%10][(column+9)%10] {count += 1}
                    if before[(row)%10][(column+1)%10] {count += 1}
                    if before[(row+9)%10][(column+9)%10] {count += 1}
                    if before[(row+9)%10][(column)%10] {count += 1}
                    if before[(row+9)%10][(column+1)%10] {count += 1}
                    return count
                }
                
                
                // Function call to get number of living neighbors
                
                neighborsAlive = hoodCount(before, row:row, column:column)
                
                currentCell = before[row][column]
                
                // Set array after for one cell based on game logic switch on number of living neighbors
                
                switch neighborsAlive {
                case 0..<2:
                    after[row][column] = false
                case 2:
                    switch currentCell {
                    case true:
                        after[row][column] = true
                    case false:
                        after[row][column] = false
                    }
                case 3:
                    after[row][column] = true
                default:
                    after[row][column] = false
                }
                
                
            }
        }
        
        // Count the next generation lives based upon the above and show in Text View
        
        count = totalCount(after)
        toPrint += "\rAlive after = \(count)."
        
        outputProblem2.text = toPrint
        
    }
    
    
    
    @IBOutlet weak var outputProblem2: UITextView!
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
