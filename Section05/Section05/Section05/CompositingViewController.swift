//
//  CompositingViewController.swift
//  Section05
//
//  Created by Van Simmons on 2/16/15.
//  Copyright (c) 2015 ComputeCycles, LLC. All rights reserved.
//

import UIKit
import Section05Views

enum Image: String {
    case Autumn   = "Autumn"
    case Building = "Building"
    case City     = "City"
    case Clouds   = "Clouds"
    case Flowers  = "Flowers"
    case River    = "River"
    case Snow     = "Snow"
    case Statue   = "Statue"
    case Sunrise  = "Sunrise"
    case Trees    = "Trees"
    
    static let allArray = [Image.Autumn, Image.Building, Image.City, Image.Clouds,
        Image.Flowers, Image.River, Image.Snow, Image.Statue, Image.Sunrise, Image.Trees]
    
    static func all() -> [Image] {
        return allArray
    }
}

class CompositingViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var cellImageView:UIImageView?
    @IBOutlet var cellLabel:UILabel?
    
    var images:[UIImage] = []
    var compositorNib:UINib = UINib(nibName: "Compositor", bundle: NSBundle.mainBundle())
    
    override func viewDidLoad() {
        for img in Image.all() {
            let image = UIImage(named: img.rawValue)!
            images.append(image)
        }
        tableView.rowHeight = min(tableView.frame.size.width-30, tableView.frame.size.height-40)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        let op = NSBlockOperation {
            self.tableView.rowHeight = min(self.tableView.frame.size.width-30,
                self.tableView.frame.size.height-40)
            self.tableView.reloadData()
        }
        NSOperationQueue.mainQueue().addOperation(op)
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) 
            cell.selectionStyle = .Default
            cell.textLabel!.backgroundColor = UIColor.clearColor()
            let row = indexPath.row % 10
            var iv = UIImageView(frame: cell.imageView!.frame)
            var newCell = compositorNib.instantiateWithOwner(self, options: nil)
            self.cellLabel!.text = "\(Image.all()[row].rawValue), Row: \(indexPath.row)"
            self.cellImageView!.image = images[row]
            let i = cellImageView!.compositedImage()
            cell.imageView!.image = i
            return cell
    }
    
}