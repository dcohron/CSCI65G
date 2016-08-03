//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//


import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    
    let engine = StandardEngine.sharedInstance
    
//    let grid = StandardEngine.sharedInstance.grid
    
    @IBOutlet weak var gridView : GridView!
    
    //  Call engine and advance one generation
    @IBAction func stepButton(sender: AnyObject) {
        engine.step()
    }
    
    //  Save current grid, prompt for name, save back to tableView
    @IBAction func saveButton(sender: AnyObject) {
    }
    
    //  Reset completely clears contents of grid (back to empty?)
    @IBAction func resetButton(sender: AnyObject) {
        let newGrid = Grid(engine.grid.rows, engine.grid.cols)
        engine.grid = newGrid
        print("Reset")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        engine.delegate = self
        gridView.setNeedsDisplay()
        if engine.timerOn == true {
            engine.startTimer()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if engine.timerOn == true {
            engine.cancelTimer()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Draw entire grid
    func engineDidUpdate(withGrid: GridProtocol) {
        gridView.setNeedsDisplay()
    }
    
// Close the SimulationViewController class definition
}

