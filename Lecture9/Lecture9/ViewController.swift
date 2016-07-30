//
//  ViewController.swift
//  Lecture9
//
//  Created by Van Simmons on 7/20/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit


struct configData {
    var title: String
    let contents: Array<(Int, Int)>
    
    static func fromJSON (json: AnyObject) -> configData! {
        if let dict = json as? Dictionary<String, AnyObject> {
            let title = dict["title"] as? String
            let contentArray = dict["contents"] as? Array<Array<Int>>
            let contents = contentArray?.map({ intArray in
                return (intArray[0],intArray[1])
            })
            return configData(title: title!, contents: contents!)
        }
        else { return nil }
    }
}




class ViewController: UITableViewController {
    
//    private var names = ["Van", "Nate", "JP"]
    
    private var configDataArray:Array<configData> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        
//  1)  Data like for final project
        
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
        
        let fetcher = Fetcher()
        fetcher.requestJSON(url) { (json, message) in
            if let json = json {
                let array: Array<configData> = (json as! Array<AnyObject>).map({ return configData.fromJSON($0)})
                self.configDataArray = array
                print(array)
            }
            
            let op = NSBlockOperation {
                self.tableView.reloadData()
            }
            NSOperationQueue.mainQueue().addOperation(op)
        }
        
//  2) Data for class example. Do one or the other as data is different structure
        
//        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=boston,%20ma&appid=77e555f36584bc0c3d55e1e584960580")!
//        let fetcher = Fetcher()
//        fetcher.requestJSON(url) { (json, message) in
//            if let json = json,
//                dict = json as? Dictionary<String, AnyObject> {
//                print(dict)
//                    let keys = dict.keys
//                    self.names = Array(keys)
//                    print(self.names)
//                    let op = NSBlockOperation {
//                        self.tableView.reloadData()
//                    }
//                NSOperationQueue.mainQueue().addOperation(op)
//                
//                }
//            else {print("JSON- ERROR")}
//        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addName(sender: AnyObject) {
        let newItem = configData (title: "newConfig", contents: [])
        configDataArray.append(newItem)
        let itemRow = configDataArray.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }

    //MARK: UITableViewDelegation
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configDataArray.count
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
        nameLabel.text = configDataArray[row].title
        cell.tag = row
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            configDataArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editingRow = (sender as! UITableViewCell).tag
        let editingString = configDataArray[editingRow].title
        guard let editingVC = segue.destinationViewController as? EditViewController
            else {
                preconditionFailure("Another wtf?")
            }
        editingVC.name = editingString
        editingVC.commit = {
            self.configDataArray[editingRow].title = $0
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath],
                withRowAnimation: .Automatic)
        }
    }
    

}

