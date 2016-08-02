//
//  ConfigurationViewController.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit


//  JSON is made up of Array, Dictionary, Boolean, Integer, Double/Float, String
struct configData {
    var title: String
    let positions: Array<Position>
    
    static func fromJSON (json: Dictionary<String, AnyObject>) -> configData {
        let title = json["title"] as! String
        let contents = json["contents"] as! Array<Array<Int>>
        let positions = contents.map({ (intArray) -> Position in
            return Position(intArray.first!,intArray.last!)
        })
        return configData(title: title, positions: positions)
    }
}


class ConfigurationViewController: UITableViewController, EngineDelegate {
    
//    private var configDataArray:Array<configData> = []
    
    let engine = StandardEngine.sharedInstance
    
    private var configurations:Array<configData> {
        get {
            return engine.configDataArray
        }
        set {
            engine.configDataArray = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        engine.loadConfigurations("https://dl.dropboxusercontent.com/u/7544475/S65g.json")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        engine.delegate = self
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        // do nothing
    }
    
    func engineDidUpdate(withConfigurations: Array<configData>) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addName(sender: AnyObject) {
        let newItem = configData (title: "newConfig", positions: [])
        configurations.append(newItem)
        let itemRow = configurations.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Default")
            else {
                preconditionFailure("missing Default reuse identifier")
        }
        let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("wtf?")
        }
        nameLabel.text = configurations[row].title
        cell.tag = row
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            configurations.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editingRow = (sender as! UITableViewCell).tag
        let editingString = configurations[editingRow].title
        guard let editingVC = segue.destinationViewController as? ConfigurationEditorViewController
            else {
                preconditionFailure("Another wtf?")
        }
        editingVC.configuration = configurations[editingRow]
        editingVC.commit = {
            self.configurations[editingRow].title = $0
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                  withRowAnimation: .Automatic)
        }
    }
// Close ConfigurationViewController class
}
