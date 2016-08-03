//
//  ViewController.swift
//  UIAlert test
//
//  Created by David Cohron on 8/3/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var tField: UITextField!
    
    func configurationTextField(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = "Enter an item"
        tField = textField
    }
    
    func handleCancel(alertView: UIAlertAction!)
    {
        print("Cancelled !!")
    }
    
    var alert = UIAlertController(title: "Enter Input", message: "", preferredStyle: .Alert)
    
    alert.addTextFieldWithConfigurationHandler(configurationTextField)
    alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler:handleCancel))
    alert.addAction(UIAlertAction(title: "Done", style: .Default, handler:{ (UIAlertAction) in
    print("Done !!")
    
    print("Item : \(self.tField.text)")
    }))
    self.presentViewController(alert, animated: true, completion: {
    print("completion block")
    })
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

