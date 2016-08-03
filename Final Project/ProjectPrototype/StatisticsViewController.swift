//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//


import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var generationBox: UITextField!
    
    @IBOutlet weak var aliveTextBox: UITextField!
   
    @IBOutlet weak var bornTextBox: UITextField!
    
    @IBOutlet weak var diedTextBox: UITextField!
  
    @IBOutlet weak var emptyTextBox: UITextField!
    
    
    let engine = StandardEngine.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        displayCounts()
    }
    
    func displayCounts() {
        generationBox.text = String(engine.genCount)
        aliveTextBox.text = String(engine.grid.alive)
        bornTextBox.text = String(engine.grid.born)
        diedTextBox.text = String(engine.grid.died)
        emptyTextBox.text = String(engine.grid.empty)
    }
    
}
