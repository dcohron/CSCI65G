//
//  FirstViewController.swift
//  Assignment4
//
//  Created by David Cohron on 7/13/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {

    @IBOutlet weak var rowBox: UITextField!
    
    @IBOutlet weak var colBox: UITextField!
    
    //  Accept input from the stepper
    //  Notify Standard Engine that the number of rows has changed
    @IBAction func rowStepperChanged(sender: UIStepper) {
        rowBox.text = String(Int(sender.value))
        currentGrid.rows = Int(sender.value)
    }
    
    @IBAction func colStepperChanged(sender: UIStepper) {
        colBox.text = String(Int(sender.value))
        currentGrid.cols = Int(sender.value)
    }
    
    //  Accept input from slider
    //  Notify Standard Engine that the refresh rate has changed
    @IBAction func refreshSliderChanged(sender: UISlider) {
        currentGrid.refreshRate = Int(sender.value)
    }
    
    // Accept input from switch
    //  Notify Standard Enging that the timer is switched off
    @IBAction func refreshSwitchChanged(sender: UISwitch) {
        currentGrid.refreshTimer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set title for navigation bar
        self.navigationItem.title = "Instrumentation";
        
        // Modify the display title on the tab bar
        self.tabBarItem.title = "Instrumentation";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //  The following two functions are not necessary as can update text views in the IBAction
    func currentGrid(currentGrid: StandardEngine, didUpdateRows modelRows: Int) {
        rowBox.text = String(modelRows)
    }
    
    func currentGrid(currentGrid: StandardEngine, didUpdateColumns modelColumns: Int) {
        colBox.text = String(modelColumns)
    }

}

