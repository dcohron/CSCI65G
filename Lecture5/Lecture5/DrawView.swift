//
//  Drawing.swift
//  Lecture5
//
//  Created by Van Simmons on 7/5/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    private var allPoints = [UITouch : [CGPoint]]()
    private var colors = [UITouch : UIColor]()
    
    var strokeColor: UIColor = UIColor.blackColor()
    
    override func awakeFromNib() {
        self.multipleTouchEnabled = true
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let currentContext = UIGraphicsGetCurrentContext()
        for (touch, points) in self.allPoints {
            self.drawPoints(points, color: self.colors[touch]!, context: currentContext!)
        }
    }
    
    func drawPoints(points: [CGPoint], color: UIColor, context: CGContextRef) {
        if points.count > 1 {
            let path = CGPathCreateMutable()
            let firstPoint = points[0]
            CGPathMoveToPoint(path, nil, firstPoint.x, firstPoint.y)
            
            for pointIndex in 1..<points.count {
                let point = points[pointIndex]
                CGPathAddLineToPoint(path, nil, point.x, point.y)
            }
            
            CGContextSetStrokeColorWithColor(context, color.CGColor)
            CGContextSetLineWidth(context, 5.0)
            CGContextAddPath(context, path)
            CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.allPoints[touch ] = [CGPoint]()
            self.colors[touch ] = self.strokeColor
            self.processTouch(touch )
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.processTouch(touch )
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.processTouch(touch )
        }
    }
    
    func processTouch(touch: UITouch) {
        let point = touch.locationInView(self)
        self.allPoints[touch]?.append(point)
        self.setNeedsDisplay()
    }
}
