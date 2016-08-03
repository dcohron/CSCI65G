//
//  ConfigurationViewController.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit


//  JSON is made up of Array, Dictionary, Boolean, Integer, Double/Float, String
struct Configuration {
    var title: String
    var positions: Array<Position>
    
    static func fromJSON(json: Dictionary<String, AnyObject>) -> Configuration {
        let title = json["title"] as! String
        
        let contents = json["contents"] as! Array<Array<Int>>
        
        let positions = contents.map { (intArray) -> Position in
            return Position(intArray.first!, intArray.last!)
        }
        
        return Configuration(title: title, positions: positions)
    }
}


class ConfigurationViewController: UITableViewController, EngineDelegate {
    
    
    let engine = StandardEngine.sharedInstance
    
    private var configurations:Array<Configuration> {
        get {
            return engine.configurations
        }
        
        set {
            engine.configurations = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        engine.loadConfigurations("https://dl.dropboxusercontent.com/u/7544475/S65g.json")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        engine.configurationIndex = nil
        engine.delegate = self
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        // do nothing
    }
    
    func engineDidUpdate(withConfigurations: Array<Configuration>) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addConfiguration(sender: AnyObject) {
        configurations.append(Configuration(title: "Add new name...", positions: []))
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Default") else { preconditionFailure("missing Default reuse identifier") }
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
        guard let editingVC = segue.destinationViewController as? ConfigurationEditorViewController else { preconditionFailure("Another wtf?") }
        
        engine.configurationIndex = editingRow
        print(configurations[editingRow].title)
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
