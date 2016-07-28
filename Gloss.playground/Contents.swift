import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//DataManager.getTopAppsDataFromFileWithSuccess { (data) -> Void in
// or
DataManager.getTopAppsDataFromItunesWithSuccess { (data) -> Void in
    var json: [String: AnyObject]!

    // 1
    do {
        json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
    } catch {
        print(error)
        XCPlaygroundPage.currentPage.finishExecution()
    }

    // 2
    guard let topApps = TopApps(json: json) else {
        print("Error initializing object")
        XCPlaygroundPage.currentPage.finishExecution()
    }

    // 3
    for item in 0..<25 {
        guard let nextItem = topApps.feed?.entries?[item].name else {
            print("No such item")
            XCPlaygroundPage.currentPage.finishExecution()
        }

        print("#\(item) \(nextItem)")

    }
    
    XCPlaygroundPage.currentPage.finishExecution()
    
}
