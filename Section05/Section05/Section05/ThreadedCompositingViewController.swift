//
//  ThreadedCompositingViewController.swift
//  Section05
//
//  Created by Van Simmons on 2/16/15.
//  Copyright (c) 2015 ComputeCycles, LLC. All rights reserved.
//

import UIKit

class ThreadedCompositingViewController: CompositingViewController, UITableViewDataSource, UITableViewDelegate {

    private struct OpQueueStatic {
        static var _dispatchOpQueue: NSOperationQueue?
        static var _token: dispatch_once_t = 0
    }
    
    class var opQueue: NSOperationQueue {
        dispatch_once(&OpQueueStatic._token) {
            OpQueueStatic._dispatchOpQueue = NSOperationQueue()
        }
        return OpQueueStatic._dispatchOpQueue!
    }
    
    var placeHolder:UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ThreadedCompositingViewController.opQueue.maxConcurrentOperationCount = 1

        self.compositorNib.instantiateWithOwner(self, options: nil)
        var newCell = self.cellImageView!
        var newLabel = self.cellLabel!
        newLabel.text = "Compositing..."
        placeHolder = newCell.compositedImage()!
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

            var op = NSBlockOperation { () -> Void in
                autoreleasepool {
                    let row = indexPath.row % 10
                    if cell.tag == tag {
                        var iv = UIImageView(frame: cell.imageView!.frame)
                        newCell.image = self.images[row]
                        newLabel.text! = "\(Image.all()[row].rawValue), Row: \(indexPath.row)"
                        let i = newCell.compositedImage()
                        
                        var mainOp = NSBlockOperation { () -> Void in
                            if cell.tag == tag {
                                cell.imageView!.image = i
                            }
                        }
                        NSOperationQueue.mainQueue().addOperation(mainOp)
                    }
                }
            }
            ThreadedCompositingViewController.opQueue.addOperation(op)
            return cell
    }
    
}
