//
//  InstrumentationViewController.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//




import UIKit

class InstrumentationViewController: UIViewController {

    let engine = StandardEngine.sharedInstance
    
    @IBOutlet weak var rowBox: UITextField!
    
    @IBOutlet weak var columnBox: UITextField!
    
    @IBOutlet weak var URLBox: UITextField!
    
    
    //  Accept input URL and fetch json data from that location
    @IBAction func fetchURL(sender: AnyObject) {
        let URLString = URLBox.text
        engine.loadConfigurations(URLString!)
    }
    
    //  Accept input from the row stepper
    //  Notify Standard Engine that the number of rows has changed
    @IBAction func rowStepper(sender: UIStepper) {
        engine.rows = Int(sender.value)
        rowBox.text = String(engine.rows)
    }
 
    //  Accept input from the column stepper
    //  Notify Standard Engine that the number of cols has changed
    @IBAction func columnStepper(sender: UIStepper) {
        engine.cols = Int(sender.value)
        columnBox.text = String(engine.cols)
    }
    
    //  Accept input from refresh slider
    //  Notify Standard Engine that the refresh rate has changed
    @IBAction func refreshSlider(sender: UISlider) {
        engine.refreshRate = Double(1/(sender.value))
        print(engine.refreshRate)
    }
    
    // Accept input from refresh switch
    //  Notify Standard Engine that the timer is switched off
    @IBAction func refreshSwitch(sender: UISwitch) {
        engine.timerOn == true ? (engine.timerOn = false) : (engine.timerOn = true)
        print(engine.timerOn)
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

// Close Instrumentation View Controller class
}

