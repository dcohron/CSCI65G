//
//  Engine.swift
//  TableViewExampe
//
//  Created by Karan Singhal on 7/25/16.
//  Copyright © 2016 Harvard University. All rights reserved.
//

import UIKit


protocol EngineDelegate {
    func dataChanged()
}

class Engine: NSObject, UITableViewDataSource {
    
    var cities: [String]
    var delegates: [EngineDelegate] = []
    
    override init() {
        cities = ["Boston", "Chicago", "Philadelphia", "Washington D.C", "Miami", "New York"]
    }
    
    func addDelegate(delegate: EngineDelegate) {
        delegates.append(delegate)
    }
    
    func addCity(name: String) {
        cities.append(name)
        
        NSNotificationCenter.defaultCenter().postNotificationName("citiesChanged", object: sharedCitiesData, userInfo: ["newCity" : name])
        
        delegates.forEach { (delegate) in
            delegate.dataChanged()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell") as! CityTableViewCell
        cell.cityNameLabel.text = cities[indexPath.row]
        if (indexPath.row % 2 != 0) {
            cell.mySwitch.setOn(false, animated: true)
        }
        
        return cell
    }
}

let sharedCitiesData = Engine()

