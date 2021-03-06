//
//  GridView.swift
//  Assignment3
//
//  Created by David Cohron on 7/8/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit


// Declare the grid as an array of enum type CellState
// This is dangerous but necessary to avoid pass by copy
var grid:[[CellState]] = []

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
            setNeedsDisplay()
        }
    }
    @IBInspectable var column: Int = 20 {
        didSet {
            grid = initializeGrid(row, ydimension:column)
            setNeedsDisplay()
        }
    }
    @IBInspectable var livingColor: UIColor = UIColor.cyanColor()
    @IBInspectable var bornColor: UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor: UIColor = UIColor.whiteColor()
    @IBInspectable var diedColor: UIColor = UIColor.purpleColor()
    @IBInspectable var gridColor: UIColor = UIColor.yellowColor()
    @IBInspectable var gridWidth: CGFloat = 1.0
    var cellDim: CGFloat {return CGFloat(240/row)}

    
//     Grid initializer
    func initializeGrid (xdimension: Int, ydimension: Int) -> [[CellState]] {
        var newGrid:[[CellState]] = []
        newGrid = Array(count: xdimension, repeatedValue: Array(count: ydimension, repeatedValue: .Empty))
        return newGrid
    }

    
    
    
    
    // Problem 4
    //  Now draw what I want.  
    // "I am the drawing captain now."- see Captain Phillips with Tom Hanks
    override func drawRect(rect: CGRect) {
        
        
        
        //  Loops to draw individual cells in color corresponding to the CellState
        
        for x in 0..<row {
            for y in 0..<column {
                //set rect for next cell
                let cellRect:CGRect = CGRectMake((cellDim * CGFloat(x)), (cellDim * CGFloat(y)), cellDim, cellDim)
                
                //set the fill color for the new cell
                switch (grid[x][y]) {
                case .Empty:
                    emptyColor.setFill()
                case .Living:
                    livingColor.setFill()
                case .Born:
                    bornColor.setFill()
                case .Died:
                    diedColor.setFill()
                }
                
                let path = UIBezierPath(ovalInRect: cellRect)
                path.fill()
                
                // Perhaps too clever but instead of drawing grid lines that may be overwritten
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

            }

        }
        
    // close drawRect
    }
    
    
    
    //  Touch handler crashes at line 176 for "EXC BAD Instruction" and have rewritten code many different ways
    //     and tracked through breakpoints in debugger and Googled error, Alas dear Yorrick,to no avail.
    //     BUT, if this worked it should just draw the single cell and not redraw the entire grid
    
    // Problem 5
    // Touch handlers
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
//            self.allPoints[touch ] = [CGPoint]()
//            self.colors[touch ] = self.strokeColor
            self.processTouch(touch)
        }
    }
    
        override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
            if let touch = touches.first {
                self.processTouch(touch)
            }
        }
    
        override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
            if let touch = touches.first {
                self.processTouch(touch)
            }
        }

    
        // Same code to process all three touch types
        func processTouch(touch: UITouch) {
            let currentPoint = touch.locationInView(self)
            let rowWidth = self.bounds.width/CGFloat(row)
            let columnHeight = self.bounds.height/CGFloat(column)
            row = Int(floor(currentPoint.x/rowWidth))
            column = Int(floor(currentPoint.y/columnHeight))
            
            // Toggle CellState of touched cell
            grid[row][column] = CellState.toggle(grid[row][column])
            let changeCellRect:CGRect = CGRectMake((rowWidth * CGFloat(row)), (columnHeight * CGFloat(column)), cellDim, cellDim)
            setNeedsDisplayInRect(changeCellRect)
        }


    
    
// close GridView class
}






// Problem #1
enum CellState: String {
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    
    // Better way than described in assignment
    func betterDescription() -> String {
        return self.rawValue
    }
    //  No reason to use Switch except called for explicitly in assignment
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
    
    static func toggle(value: CellState) -> CellState {
        switch value {
        case .Empty, .Died:
            return .Living
        case .Living, .Born:
            return .Empty
        }
    }
    
}






