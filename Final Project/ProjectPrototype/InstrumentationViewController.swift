//
//  InstrumentationViewController.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//




import UIKit

class InstrumentationViewController: UIViewController {

    
    @IBOutlet weak var rowBox: UITextField!
    
    @IBOutlet weak var columnBox: UITextField!
    
    //  Accept input from the row stepper
    //  Notify Standard Engine that the number of rows has changed
    @IBAction func rowStepper(sender: UIStepper) {
        StandardEngine.sharedInstance.rows += Int(sender.value)
        rowBox.text = String(StandardEngine.sharedInstance.rows)
    }
 
    //  Accept input from the column stepper
    //  Notify Standard Engine that the number of cols has changed
    @IBAction func columnStepper(sender: UIStepper) {
        StandardEngine.sharedInstance.cols += Int(sender.value)
        columnBox.text = String(StandardEngine.sharedInstance.cols)
    }
    
    //  Accept input from refresh slider
    //  Notify Standard Engine that the refresh rate has changed
    @IBAction func refreshSlider(sender: UISlider) {
        StandardEngine.sharedInstance.refreshRate = Double(sender.value)
    }
    
    // Accept input from refresh switch
    //  Notify Standard Engine that the timer is switched off
    @IBAction func refreshSwitch(sender: UISwitch) {
        StandardEngine.sharedInstance.refreshTimer?.cancelTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

