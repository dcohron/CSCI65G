//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//





import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    
    let gridViewGrid: GridView = GridView()
    
    //  Call engine and advance one generation
    @IBAction func stepButton(sender: AnyObject) {
    }
    
    //  Save current grid, prompt for name, save back to tableView
    @IBAction func saveButton(sender: AnyObject) {
    }
    
    //  Reset completely clears contents of grid (back to empty?)
    @IBAction func resetButton(sender: AnyObject) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        StandardEngine.sharedInstance.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Draw entire grid
    func engineDidUpdate(withGrid: GridProtocol) {
        
        var xDim: CGFloat {return CGFloat(240/withGrid.cols)}
        var yDim: CGFloat {return CGFloat(240/withGrid.rows)}
                
        // Call for redraw of entire grid, one cell at a time
        for x in 0..<withGrid.cols {
            for y in 0..<withGrid.rows {
                //set rect for next cell
                let cellRect:CGRect = CGRectMake((xDim * CGFloat(x)), (yDim * CGFloat(y)), xDim, yDim)
                let cellState: CellState = withGrid(i:x, j:y)
                
                // Function call to draw cell
                gridViewGrid.drawCell(cellRect, cellState: CellState)
            }
        }
    }
    
// Close the SimulationViewController class definition
}

