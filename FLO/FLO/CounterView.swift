//
//  CounterView.swift
//  FLO
//
//  Created by David Cohron on 7/8/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {
    
    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <=  NoOfGlasses {
                //the view needs to be refreshed
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    override func drawRect(rect: CGRect) {
        
        // Draw the arc
        // 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        // 2
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        // 3
        let arcWidth: CGFloat = 76
        
        // 4
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        // 5
        var path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        // 6
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        
        //Draw the outline of the arc
        
        //1 - first calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        
        //then calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
        
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //2 - draw the outer arc
        var outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - 2.5,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
        //3 - draw the inner arc
        outlinePath.addArcWithCenter(center,
                                     radius: bounds.width/2 - arcWidth + 2.5,
                                     startAngle: outlineEndAngle,
                                     endAngle: startAngle,
                                     clockwise: false)
        
        //4 - close the path
        outlinePath.closePath()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        
        
        //Counter View markers
        
        let context = UIGraphicsGetCurrentContext()
        
        //1 - save original state
        CGContextSaveGState(context)
        outlineColor.setFill()
        
        let markerWidth:CGFloat = 5.0
        let markerSize:CGFloat = 10.0
        
        //2 - the marker rectangle positioned at the top left
        var markerPath = UIBezierPath(rect:
            CGRect(x: -markerWidth/2,
                y: 0,
                width: markerWidth,
                height: markerSize))
        
        //3 - move top left of context to the previous center position
        CGContextTranslateCTM(context,
                              rect.width/2,
                              rect.height/2)
        
        for i in 1...NoOfGlasses {
            //4 - save the centered context
            CGContextSaveGState(context)
            
            //5 - calculate the rotation angle
            var angle = arcLengthPerGlass * CGFloat(i) + startAngle - π/2
            
            //rotate and translate
            CGContextRotateCTM(context, angle)
            CGContextTranslateCTM(context,
                                  0,
                                  rect.height/2 - markerSize)
            
            //6 - fill the marker rectangle
            markerPath.fill()
            
            //7 - restore the centred context for the next rotate
            CGContextRestoreGState(context)
        }
        
        //8 - restore the original state in case of more painting
        CGContextRestoreGState(context)
        
    }
}
