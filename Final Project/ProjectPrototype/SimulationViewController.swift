//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//





import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    
    @IBOutlet weak var gridView : GridView!
    
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
        gridView.setNeedsDisplay()
    }
    
// Close the SimulationViewController class definition
}

