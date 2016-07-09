//
//  Background View.swift
//  FLO
//
//  Created by David Cohron on 7/8/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

@IBDesignable

class BackgroundView: UIView {
    
    //1
    @IBInspectable var lightColor: UIColor = UIColor.orangeColor()
    @IBInspectable var darkColor: UIColor = UIColor.yellowColor()
    @IBInspectable var patternSize: CGFloat = 200.0
    
    override func drawRect(rect: CGRect) {
        //2
        let context = UIGraphicsGetCurrentContext()
        
        //3
        CGContextSetFillColorWithColor(context, darkColor.CGColor)
        
        //4
        CGContextFillRect(context, rect)
    }


    let drawSize = CGSize(width: patternSize, height: patternSize)
    
    //insert code here
    
    
    let trianglePath = UIBezierPath()
    //1
    trianglePath.moveToPoint(CGPoint(x:drawSize.width/2, y:0))
    //2
    trianglePath.addLineToPoint(CGPoint(x:0,
    y:drawSize.height/2))
    //3
    trianglePath.addLineToPoint(CGPoint(x:drawSize.width,
    y:drawSize.height/2))
    
    //4
    trianglePath.moveToPoint(CGPoint(x: 0,
    y: drawSize.height/2))
    //5
    trianglePath.addLineToPoint(CGPoint(x: drawSize.width/2,
    y: drawSize.height))
    //6
    trianglePath.addLineToPoint(CGPoint(x: 0,
    y: drawSize.height))
    
    //7
    trianglePath.moveToPoint(CGPoint(x: drawSize.width,
    y: drawSize.height/2))
    //8
    trianglePath.addLineToPoint(CGPoint(x:drawSize.width/2,
    y:drawSize.height))
    //9
    trianglePath.addLineToPoint(CGPoint(x: drawSize.width,
    y: drawSize.height))
    
    lightColor.setFill()
    trianglePath.fill()


}