//
//  GCDThreadingCompositingViewController.swift
//  Section05
//
//  Created by Van Simmons on 2/18/15.
//  Copyright (c) 2015 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class GCDThreadingCompositingViewController: ThreadedCompositingViewController {

    private struct QueueStatic {
        static var _dispatchQueue: dispatch_queue_t?
        static var _token: dispatch_once_t = 0
    }

    class var dispatchQueue: dispatch_queue_t {
        dispatch_once(&QueueStatic._token) {
            let attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL,
                QOS_CLASS_BACKGROUND,
                0)
            QueueStatic._dispatchQueue = dispatch_queue_create("Bluetooth.dispatchQueue", attr)
        }
        return QueueStatic._dispatchQueue!
    }

    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) 
            cell.selectionStyle = .Default
            cell.textLabel!.backgroundColor = UIColor.clearColor()
            cell.tag = indexPath.row
            cell.imageView!.image = placeHolder
            
            let tag = cell.tag
            self.compositorNib.instantiateWithOwner(self, options: nil)
            var newCell = self.cellImageView!
            var newLabel = self.cellLabel!
            
            dispatch_async(GCDThreadingCompositingViewController.dispatchQueue) { () -> Void in
                autoreleasepool {
                    let row = indexPath.row % 10
                    if cell.tag == tag {
                        var iv = UIImageView(frame: cell.imageView!.frame)
                        newCell.image = self.images[row]
                        newLabel.text! = "\(Image.all()[row].rawValue), Row: \(indexPath.row)"
                        let i = newCell.compositedImage()
                        
                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
                            if cell.tag == tag {
                                cell.imageView!.image = i
                            }
                        }
                    }
                }
            }

            return cell
    }

}
