//
//  MainViewController.swift
//  Section05
//
//  Created by Van Simmons on 2/16/15.
//  Copyright (c) 2015 ComputeCycles, LLC. All rights reserved.
//

import Foundation
import UIKit

enum ExampleViews: Int {
    case Graphing = 0
    case Compositing
    case ThreadedCompositing
    case GCDThreadedCompositing
}

class MainViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("MainCell", forIndexPath: indexPath) 
            cell.selectionStyle = .None
            cell.textLabel!.backgroundColor = UIColor.clearColor()
            let row = indexPath.row
            switch row {
            case ExampleViews.Graphing.rawValue:
                cell.textLabel!.text = "Graphing"
            case ExampleViews.Compositing.rawValue:
                cell.textLabel!.text = "Compositing"
            case ExampleViews.ThreadedCompositing.rawValue:
                cell.textLabel!.text = "ThreadedCompositing"
            case ExampleViews.GCDThreadedCompositing.rawValue:
                cell.textLabel!.text = "GCDThreadedCompositing"
            default:
                cell.textLabel!.text = "Unknown"
                cell.userInteractionEnabled = false
            }
            return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        switch row {
        case ExampleViews.Graphing.rawValue:
            self.performSegueWithIdentifier("Graphing", sender: tableView)
        case ExampleViews.Compositing.rawValue:
            self.performSegueWithIdentifier("Compositing", sender: tableView)
        case ExampleViews.ThreadedCompositing.rawValue:
            self.performSegueWithIdentifier("ThreadedCompositing", sender: tableView)
        case ExampleViews.GCDThreadedCompositing.rawValue:
            self.performSegueWithIdentifier("GCDThreadedCompositing", sender: tableView)
        default:
            NSLog("Selected default cell")
        }
        
    }

}
