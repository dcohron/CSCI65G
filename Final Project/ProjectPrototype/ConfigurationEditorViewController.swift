//
//  ConfigurationEditorViewController.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class ConfigurationEditorViewController: UIViewController, EngineDelegate {
    
    
    var name:String?
    var commit: (String -> Void)?
    
    let engine = StandardEngine.sharedInstance
    
    
    @IBOutlet weak var editGridView: GridView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func save(sender: AnyObject) {
        guard let newText = nameTextField.text, commit = commit
            else { return }
        commit(newText)
        navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextField.text = name
        editGridView.setNeedsDisplay()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        engine.delegate = self
        editGridView.points = engine.configuration!.positions
        editGridView.setNeedsDisplay()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Draw entire grid
    func engineDidUpdate(withGrid: GridProtocol) {
        editGridView.setNeedsDisplay()
    }

// Close ConfigurationEditorViewController class
}
