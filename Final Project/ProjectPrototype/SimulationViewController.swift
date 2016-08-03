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
    
    @IBOutlet weak var gridView : GridView!
    
    //  Call engine and advance one generation
    @IBAction func stepButton(sender: AnyObject) {
        engine.step()
    }
    
    //  Save current grid, prompt for name, save back to tableView
    @IBAction func saveButton(sender: AnyObject) {
        let configName = nameAlert()
        engine.addConfigurationBasedOnGrid(configName)
    }
    
    //  Reset completely clears contents of grid (back to empty?)
    @IBAction func resetButton(sender: AnyObject) {
        let newGrid = Grid(engine.grid.rows, engine.grid.cols)
        engine.grid = newGrid
        engine.genCount = 0
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
    
    func nameAlert() -> String {
        var configName: String = ""
        
        let alert = UIAlertController(title: "Save",
                                      message: "Please enter configuration name.",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "OK",
                               style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
                                
                                if let alertTextField = alert.textFields?.first where alertTextField.text != nil {
                                    
                                    print("And the config name is... \(alertTextField.text!)!")
                                    configName = alertTextField.text!
                                }
        }
        
        let cancel = UIAlertAction(title: "Cancel",
                                   style: UIAlertActionStyle.Cancel,
                                   handler: nil)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            
            textField.placeholder = "Name here"
            
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
        return configName
    }

    
// Close the SimulationViewController class definition
}

