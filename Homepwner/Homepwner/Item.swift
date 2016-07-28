//
//  Item.swift
//  Homepwner
//
//  Created by David Cohron on 7/27/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class Item: NSObject{
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    
    init (name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        
        super.init()
    }
}


