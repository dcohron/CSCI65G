//
//  ViewController.swift
//  Lecture 9 class work
//
//  Created by David Cohron on 7/20/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private var names = ["Van", "Nat", "JP"]

    @IBAction func addName(sender: AnyObject) {
        names.append("Add new name")
        let itemRow = names.count-1
        let itemPath = NSIndexPath(forRow: itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegation
    //  This is way to set a bookmark.  Activated my clicking on bar "ViewController" above
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
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
        
        nameLabel.text = names[row]
        cell.tag = row
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            names.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    
// close class ViewController
}

