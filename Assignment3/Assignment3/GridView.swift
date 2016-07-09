//
//  GridView.swift
//  Assignment3
//
//  Created by David Cohron on 7/8/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

@IBDesignable

class GridView: UIView {

    
    @IBInspectable var row: Int = 20
    @IBInspectable var column: Int = 20
    @IBInspectable var livingColor: UIColor = UIColor.yellowColor()
    @IBInspectable var emptyColor: UIColor = UIColor.whiteColor()
    @IBInspectable var bornColor: UIColor = UIColor.greenColor()
    @IBInspectable var diedColor: UIColor = UIColor.purpleColor()
    @IBInspectable var gridWidth: CGFloat = 200.0
}
