//
//  DataManager.swift
//  
//
//  Created by David Cohron on 7/22/16.
//
//

import Foundation


let fileLocation = "/Users/Nick/Downloads/S65g-1.json"

let TopAppURL = "https://itunes.apple.com/us/rss/topgrossingipadapplications/limit=25/json"

public class DataManager {
    
    public class func getDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let filePath = NSBundle.mainBundle().pathForResource("S65g-1 (1)", ofType:"json")
            let data = try! NSData(contentsOfFile:filePath!,
                options: NSDataReadingOptions.DataReadingUncached)
            success(data: data)
        })
    }
    
    public class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        let loadDataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        }
        
        loadDataTask.resume()
    }
    
    public class func getTopAppsDataFromItunesWithSuccess(success: ((iTunesData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: TopAppURL)!, completion:{(data, error) -> Void in
            //2
            if let data = data {
                //3
                success(iTunesData: data)
            }
        })
    }
    
}
