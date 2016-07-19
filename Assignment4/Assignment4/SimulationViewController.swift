//
//  SecondViewController.swift
//  Assignment4
//
//  Created by David Cohron on 7/13/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    
    
    @IBOutlet weak var gridPane: GridView!

    @IBAction func runNextGen(sender: UIButton) {
        
        currentGrid = step(currentGrid)
        
        gridPane.setNeedsDisplay()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set title for navigation bar
        self.navigationItem.title = "Simulation";
        
        // Modify the display title on the tab bar
        self.tabBarItem.title = "Simulation";
        
        // Set up game by instantiating a Standard Engine
        StandardEngine.sharedInstance.rows = 20
        StandardEngine.sharedInstance.cols = 20
        let currentGrid = StandardEngine.sharedInstance
        
        // Set as delegate for Engine
        currentGrid.delegate = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func engineDidUpdate(withGrid: GridProtocol) {
        gridPane.setNeedsDisplay()
    }
    
// Close SimulationViewController
}

