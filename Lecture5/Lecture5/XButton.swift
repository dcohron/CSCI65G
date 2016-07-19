//
//  PushButton.swift
//  Lecture5
//
//  Created by Van Simmons on 7/4/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

@IBDesignable class XButton: UIButton {
    
    @IBInspectable var fillColor = UIColor.blueColor()
    @IBInspectable var xColor = UIColor.whiteColor()
    @IBInspectable var xProportion = CGFloat(0.6)
    @IBInspectable var widthProportion = CGFloat(0.08)
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
        
        //set up the width and height variables
        //for the horizontal stroke
        let lineWidth: CGFloat = sqrt(bounds.width*bounds.height) * widthProportion
        let plusHeight: CGFloat = bounds.height * xProportion
        let plusWidth: CGFloat = bounds.width * xProportion
        
        //create the path
        let plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = lineWidth
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth/2,
            y:bounds.height/2 - plusHeight/2))
        
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2,
            y:bounds.height/2 + plusHeight/2))
        
                //draw the stroke
        //        plusPath.stroke()
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2  - plusWidth/2,
            y:bounds.height/2 + plusHeight/2))
        
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2,
            y:bounds.height/2 - plusHeight/2))
        
        //set the stroke color
        xColor.setStroke()
        
        //draw the stroke
        plusPath.stroke()
    }
}
