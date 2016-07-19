//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by David Cohron on 7/13/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var numberText: UITextField!
    
    @IBOutlet weak var livingText: UITextField!
    
    @IBOutlet weak var bornText: UITextField!
    
    @IBOutlet weak var diedText: UITextField!
    
    @IBOutlet weak var emptyText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set title for navigation bar
        self.navigationItem.title = "Statistics";
        
        // Modify the display title on the tab bar
        self.tabBarItem.title = "Statistics";
        
        // Display statistics by calling function gridCount
        let stats = gridCount(currentGrid)
        livingText.text = String(stats.0)
        bornText.text = String(stats.1)
        diedText.text = String(stats.2)
        emptyText.text = String(stats.3)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
