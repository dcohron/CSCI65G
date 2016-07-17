//
//  GridView.swift
//  Assignment4
//
//  Created by David Cohron on 7/16/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    override func drawRect(rect: CGRect) {
        
        let emptyColor = UIColor.blackColor
        let livingColor = UIColor.greenColor
        let bornColor = UIColor.yellowColor
        let diedColor = UIColor.purpleColor
        
        let xCellDim = 390/currentGrid.rows
        let yCellDim = 390/currentGrid.cols
        
        
        //  Loops to draw individual cells in color corresponding to the CellState
        for x in 0..<row {
            for y in 0..<column {
                //set rect for next cell
                let cellRect:CGRect = CGRectMake((xcellDim * CGFloat(x)), (ycellDim * CGFloat(y)), xcellDim, ycellDim)
                
                //set the fill color for the new cell
                switch (currentGrid[x, y]) {
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
    
    
    // close GridView class
}
