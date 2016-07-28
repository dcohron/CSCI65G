//
//  ViewController.swift
//  TableViewExampe
//
//  Created by Karan Singhal on 7/25/16.
//  Copyright © 2016 Harvard University. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController, UITableViewDelegate, EngineDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = sharedCitiesData
        sharedCitiesData.addDelegate(self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(dataChanged), name: "citiesChanged", object: sharedCitiesData)
    }
    
    @IBAction func addCities() {
        sharedCitiesData.addCity("Houston")
        sharedCitiesData.addCity("Las Vegas")
        sharedCitiesData.addCity("London")
        sharedCitiesData.addCity("Edinburgh")
        sharedCitiesData.addCity("Mumbai")
        sharedCitiesData.addCity("Los Angeles")
        sharedCitiesData.addCity("Barcelona")
        sharedCitiesData.addCity("Madrid")
        sharedCitiesData.addCity("Milan")
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("clicked \(indexPath.row)")
    }
    
    func dataChanged() {
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: sharedCitiesData.cities.count-1, inSection: 0)] , withRowAnimation: .Left)
        tableView.endUpdates()
    }
}

