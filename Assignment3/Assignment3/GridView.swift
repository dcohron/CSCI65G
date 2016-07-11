//
//  GridView.swift
//  Assignment3
//
//  Created by David Cohron on 7/8/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

@IBDesignable


//  Problem #2
class GridView: UIView {
    

    // Set variables for the class
    
    // Start with inspectables
    // Start inspectables with row and column which are changeable by Interface Builder,
    //    but if changed will cause the array to be reinitialized to empty
    @IBInspectable var row: Int = 20 {
        didSet {
            grid = initializeGrid(row, ydimension:column)
        }
    }
    @IBInspectable var column: Int = 20 {
        didSet {
            grid = initializeGrid(row, ydimension:column)
        }
    }
    @IBInspectable var livingColor: UIColor = UIColor.cyanColor()
    @IBInspectable var bornColor: UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor: UIColor = UIColor.whiteColor()
    @IBInspectable var diedColor: UIColor = UIColor.purpleColor()
    @IBInspectable var gridColor: UIColor = UIColor.yellowColor()
    @IBInspectable var gridWidth: CGFloat = 1.0
    var cellDim: CGFloat {return CGFloat(240/row)}
    
    
    var grid: [[CellState]] = initializeGrid (row, ydimension: column)
    var nextGrid: [[CellState]] = initializeGrid (row, ydimension: column)
    var changeGrid: [(Int,Int)] = [(0,0)]
    
    // Grid initializer
    func initializeGrid (xdimension: Int, ydimension: Int) -> [[CellState]] {
        var newGrid:[[CellState]] = [[]]
//        newGrid = Array(count: xdimension, repeatedValue: Array(count: ydimension, repeatedValue: .Empty))
        return newGrid
    }

    
    
    
    // Problem 4
    //  Now draw what I want.  
    // "I am the drawing captain now."- see Captain Phillips with Tom Hanks
    override func drawRect(rect: CGRect) {
        
        //
        let context = UIGraphicsGetCurrentContext()
        
//       //
//       CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
//
//        //
//        CGContextFillRect(context, rect)
//        

        
        //set the size
        let drawSize = CGSize(width: cellDim, height: cellDim)
        
        
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        let background: UIColor = UIColor.whiteColor()
        background.setFill()
        
//        //set the fill color for the new context
//        let targetCellState = grid[0][0]
//        switch targetCellState {
//        case .Empty:
//            emptyColor.setFill()
//        case .Living:
//            livingColor.setFill()
//        case .Born:
//            bornColor.setFill()
//        case .Died:
//            diedColor.setFill()
//        }

        CGContextFillRect(drawingContext, CGRectMake(0, 0, drawSize.width, drawSize.height))
        
        //set shape and fill in shape
        let path = UIBezierPath(ovalInRect: rect)
        emptyColor.setFill()
        path.fill()
        
        // Grid lines = outline box
        //create the path
        let outlinePath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        outlinePath.lineWidth = gridWidth
        
        //move the initial point of the path
        //top left corner
        //to the start of the outline stroke
        outlinePath.moveToPoint(CGPoint(
            x:0,
            y:0))
        
        //add a point to the path at the end of the stroke
        outlinePath.addLineToPoint(CGPoint(
            x:bounds.width,
            y:0))
        
        //add a point to the path at the end of the stroke
        outlinePath.addLineToPoint(CGPoint(
            x:bounds.width,
            y:bounds.height))
            
        //add a point to the path at the end of the stroke
        outlinePath.addLineToPoint(CGPoint(
            x:0,
            y:bounds.height))
        
        //and back to the original point to close the outline box
        outlinePath.addLineToPoint(CGPoint(
            x:0,
            y:0))
        
        
        //set the stroke color
        gridColor.setStroke()
        
        //draw the stroke
        outlinePath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)

    // close drawRect
    }
    
    
//  Touch handlers commented out because it through Segmentation Error at compile time
//     Believe the source of this is in line 160 and 161 where I calculate the cell row and column
//     from the CG points returned from touch.locationInView being out of range.
    
//    // Problem 5
//    // Touch handlers
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch = touches.first {
//            let currentPoint = touch.locationInView(self)
//            row = Int(currentPoint.x%cellDim)
//            column = Int(currentPoint.y%cellDim)
//            
//            // Toggle CellState of touched cell
//            let newCellState: CellState = grid[row][column].toggle
//            grid[row][column] = newCellState
//            var changeCellRect = CGRectMake(currentPoint.x, currentPoint.y, cellDim, cellDim)
//            
//            // Call setNeedsDisplayinRect on the changed cell
//            setNeedsDisplayInRect(rect: changeCellRect)
//        }
//    }
//    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch = touches.first {
//            let currentPoint = touch.locationInView(self)
//            row = Int(currentPoint.x%cellDim)
//            column = Int(currentPoint.y%cellDim)
//            
//            // Toggle CellState of touched cell
//            let newCellState:[CellState] = grid[row][column].toggle
//            grid[row][column] = newCellState
//            changeCellRect = CGRectMake(currentPoint.x, currentPoint.y, cellDim, cellDim)
//            
//            // Call setNeedsDisplayinRect on the changed cell
//            setNeedsDisplayInRect(rect: changeCellRect)
//        }
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch = touches.first {
//            let currentPoint = touch.locationInView(self)
//            row = Int(currentPoint.x%cellDim)
//            column = Int(currentPoint.y%cellDim)
//            
//            // Toggle CellState of touched cell
//            let newCellState:[CellState] = grid[row][column].toggle
//            grid[row][column] = newCellState
//            changeCellRect = CGRectMake(currentPoint.x, currentPoint.y, cellDim, cellDim)
//            
//            // Call setNeedsDisplayinRect on the changed cell
//            setNeedsDisplayInRect(rect: changeCellRect)        }
//    }
    
    
// close GridView class
}






// Problem #1
enum CellState: String {
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    func betterDescription() -> String {
        return self.rawValue
    }
    
    func description() -> String {
        switch self {
        case Living:
            return self.rawValue
        case Empty:
            return self.rawValue
        case Born:
            return self.rawValue
        case Died:
            return self.rawValue
        }
    }
    
    
    
    func allValues() -> [CellState] {
        return [.Living, .Empty, .Born, .Died]
    }
    
    func toggle(value: CellState) -> CellState {
        switch value {
        case .Empty, .Died:
            return .Living
        case .Living, .Born:
            return .Empty
        }
    }
    
}



