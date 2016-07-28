// Playground to work on JSON

import UIKit
import XCPlayground

// typealias Payload = [String: AnyObject]


print("Entering DataManager")
DataManager.getDataFromFileWithSuccess { (data) -> Void in
    
//    var json: Payload!
//    
//    // 1
//    do {
//        json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? Payload
//    } catch {
//        print(error)
//        XCPlaygroundPage.currentPage.finishExecution()
//    }
//
//    // 2
//    guard let group = json["title"] as? Payload,
//        let title = group["title"] as? String,
//        let contents = group["contents"] as? AnyObject!
//        else { XCPlaygroundPage.currentPage.finishExecution() }
//
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
//
//    XCPlaygroundPage.currentPage.finishExecution()
    
    
    var names = [String]()
    var grids = [String]()
    
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        
//        guard let formation = json["title"] as? [[String: AnyObject]],
//            let name = formation[0] as? String,
//            let contents = formation[1] as? AnyObject
//            else { print("error")}
        
        let name = json["title"] as! String
        let contents = json["contents"] as! String
                contents
                
        names.append(name)
        grids.append(contents)
        
    }
    catch {
        print("error serializing JSON: \(error)")
    }
    
    print(names)
    
}
