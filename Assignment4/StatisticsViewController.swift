//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by David Cohron on 7/13/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set title for navigation bar
        self.navigationItem.title = "Statistics";
        
        // Modify the display title on the tab bar
        self.tabBarItem.title = "Statistics";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
