//
//  AddCityViewController.swift
//  TableViewExampe
//
//  Created by Karan Singhal on 7/25/16.
//  Copyright © 2016 Harvard University. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController, EngineDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sharedCitiesData.addDelegate(self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(dataChanged), name: "citiesChanged", object: sharedCitiesData)
    }

    func dataChanged() {
        self.nameTextField.text = nil
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        sharedCitiesData.addCity(nameTextField.text!)
    }
}
