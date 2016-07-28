//
//  JSONhandler.swift
//  JSON project
//
//  Created by David Cohron on 7/22/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import Foundation


typealias Payload = [String: AnyObject]



DataManager.getDataFromFileWithSuccess { (data) -> Void in
    
    var json: Payload!
    
    // 1
    do {
        json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? Payload
    } catch {
        print(error)
      
    }
    
    // 2
    guard let group = json["title"] as? Payload,
        let title = group["title"] as? String,
        let contents = group["contents"] as? AnyObject!
        else { print("error") }
    
    //    guard let container = title["contents"] as? Payload,
    //        let name = container["label"] as? String
    //        else { XCPlaygroundPage.currentPage.finishExecution() }
    //
    //    guard let id = title["id"] as? Payload,
    //        let link = id["label"] as? String
    //        else { XCPlaygroundPage.currentPage.finishExecution() }
    //
    // 3
    //    let entry = group(title: title, contents: contents)
    //    print(entry)
    
    print(title)
    
    
    
}