//
//  GraphView.swift
//  Graph
//
//  Created by Tim Davies on 11/08/2014.
//  Copyright (c) 2014 Tim Davies. All rights reserved.
//

import UIKit
import QuartzCore

class GraphView: UIView {

    var data:[[String:AnyObject]] = []
    private var lastRect:CGRect = CGRectMake(0, 0, 0, 0)
    private var context : CGContextRef?
    
    private let padding     : CGFloat = 30
    private var graphWidth  : CGFloat = 0
    private var graphHeight : CGFloat = 0
    private var axisWidth   : CGFloat = 0
    private var axisHeight  : CGFloat = 0
    private var everest     : CGFloat = 0
    
    // Graph Styles
    var showLines       = true
    var showPoints      = true
    var linesColor      = UIColor(white: 0.9, alpha: 1)
    var axisColor       = UIColor.grayColor()
    var graphColor      = UIColor.blackColor()
    var labelFont       = UIFont.systemFontOfSize(12)
    var labelColor      = UIColor.blackColor()
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        lastRect = CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lastRect = CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)
    }
    
    func clear(rect:CGRect) {
        println("Clearing = { x:\(rect.origin.x), y:\(rect.origin.y), w:\(rect.size.width), h:\(rect.size.height) }")
        
        context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, rect)
        CGContextSetFillColorWithColor(context, backgroundColor!.CGColor)
        CGContextFillRect(context, rect)
    }
    
    override func drawRect(rect: CGRect) {

        if lastRect.size.height < rect.size.height {
            lastRect.size.height = rect.size.height
        }
        if lastRect.size.width < rect.size.width {
            lastRect.size.width = rect.size.width
        }

        self.clear(self.bounds)
        println("Rect = { x:\(rect.origin.x), y:\(rect.origin.y), w:\(rect.size.width), h:\(rect.size.height) }")

        context = UIGraphicsGetCurrentContext()
        super.drawRect(rect)
        
        // Graph size
        graphWidth = (rect.size.width - padding) - 10
        graphHeight = rect.size.height - 40
        axisWidth = rect.size.width - 10
        axisHeight = (rect.size.height - padding) - 10
        
        // Lets work out the highest value and round to the nearest 25. 
        // This will be used to work out the position of each value
        // on the Y axis, it essentialy reperesents 100% of Y
        for point in data {
            let n : Int = (point["value"] as NSNumber).integerValue
            if CGFloat(n) > everest {
                everest = CGFloat(Int(ceilf(Float(n) / 25) * 25))
            }
        }
        
        // Draw graph AXIS
        let axisPath = CGPathCreateMutable()
        CGPathMoveToPoint(axisPath, nil, padding, 10)
        CGPathAddLineToPoint(axisPath, nil, padding, rect.size.height - 31)
        CGPathAddLineToPoint(axisPath, nil, axisWidth, rect.size.height - 31)
        CGContextAddPath(context, axisPath)
        
        CGContextSetStrokeColorWithColor(context, axisColor.CGColor)
        CGContextStrokePath(context)
        
        // Draw y axis labels and lines
        var yLabelInterval : Int = Int(everest / 5)
        for i in 0...5 {
            let y = floor((rect.size.height - padding) - CGFloat(i) * (axisHeight / 5) - 10)
            let paddedY = floor(rect.size.height - padding) - (CGFloat(i) * (axisHeight / 5))
            let label = axisLabel("\(i * yLabelInterval)", x: 0.0, y: y, w: 20.0, h: 20.0)
            addSubview(label)
            
            if(showLines && i != 0) {
                let line = CGPathCreateMutable()
                CGPathMoveToPoint(line, nil, padding + 1, paddedY)
                CGPathAddLineToPoint(line, nil, axisWidth, paddedY)
                CGContextAddPath(context, line)
                CGContextSetStrokeColorWithColor(context, linesColor.CGColor)
                CGContextStrokePath(context)
            }
        }
        
        // Lets move to the first point
        let pointPath = CGPathCreateMutable()
        let firstPoint = (data[0] as NSDictionary).objectForKey("value") as NSNumber
        let initialY : CGFloat = ceil((CGFloat(firstPoint.integerValue as Int) * (axisHeight / everest))) - 10
        let initialX : CGFloat = padding + (showPoints ? 10 : 0)
        CGPathMoveToPoint(pointPath, nil, initialX, graphHeight - initialY)
        
        // Loop over the remaining values
        for point in data {
            plotPoint(point as NSDictionary, path: pointPath)
        }
        
        // Set stroke colours and stroke the values path
        CGContextAddPath(context, pointPath)
        CGContextSetLineWidth(context, 2)
        CGContextSetStrokeColorWithColor(context, graphColor.CGColor)
        CGContextStrokePath(context)
        
        context = nil
    }
    
    
    // Plot a point on the graph
    func plotPoint(point : NSDictionary, path: CGMutablePathRef) {
        
        var arrayData = self.data as NSArray
        // work out the distance to draw the remaining points at
        let interval = Int(graphWidth) / (data.count - 1);
        
        let pointValue = point.objectForKey("value") as NSNumber
        
        // Calculate X and Y positions
        var yposition : CGFloat = ceil((CGFloat(pointValue.integerValue as Int) * (axisHeight / everest))) - 10
        var xposition : CGFloat = CGFloat(interval * (arrayData.indexOfObject(point))) + padding
        
        // If its the first point we want to nuge it in slightly
        if(arrayData.indexOfObject(point) == 0 && showPoints) {
            xposition += 10
        }
        
        // Draw line to this value
        CGPathAddLineToPoint(path, nil, xposition, graphHeight - yposition);
        
        let xLabel = axisLabel(point.objectForKey("label") as NSString,
            x: xposition - 17, y: graphHeight + 20, w: 36, h: 20)
        xLabel.textAlignment = NSTextAlignment.Center
        addSubview(xLabel)
        
        if(showPoints) {
            // Add a marker for this value
            let pointMarker = valueMarker()
            pointMarker.frame = CGRectMake(xposition - 8, ceil(graphHeight - yposition) - 8, 16, 16)
            layer.addSublayer(pointMarker)
        }
    }
    
    
    // Returns an axis label
    func axisLabel(title: NSString, x:CGFloat, y:CGFloat, w:CGFloat, h:CGFloat) -> UILabel {
        
        let label = UILabel(frame: CGRectMake(x, y, w, h))
        label.text = title
        label.font = labelFont
        label.textColor = labelColor
        label.backgroundColor = backgroundColor
        label.textAlignment = NSTextAlignment.Right
        
        return label
    }
    
    // Returns a point for plotting
    func valueMarker() -> CALayer {
        let pointMarker = CALayer()
        pointMarker.backgroundColor = backgroundColor?.CGColor
        pointMarker.cornerRadius = 8
        pointMarker.masksToBounds = true
        
        let markerInner = CALayer()
        markerInner.frame = CGRectMake(3, 3, 10, 10)
        markerInner.cornerRadius = 5
        markerInner.masksToBounds = true
        markerInner.backgroundColor = graphColor.CGColor
        
        pointMarker.addSublayer(markerInner)
        
        return pointMarker
    }
    
}
