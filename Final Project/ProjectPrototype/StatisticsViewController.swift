//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//



// Would like to add text field to show counter for generations run on this grid

//  Should statistics change as timer causes to advance grid, or just static on load?

//  Pass grid for calculation or just counts?


import UIKit

class StatisticsViewController: UIViewController {

    
    @IBOutlet weak var livingTextBox: UITextField!
   
    @IBOutlet weak var bornTextBox: UITextField!
    
    @IBOutlet weak var diedTextBox: UITextField!
  
    @IBOutlet weak var emptyTextBox: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
