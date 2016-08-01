//
//  GridView.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    @IBInspectable var aliveColor: UIColor = UIColor.cyanColor()
    @IBInspectable var bornColor: UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor: UIColor = UIColor.whiteColor()
    @IBInspectable var diedColor: UIColor = UIColor.purpleColor()
    @IBInspectable var gridColor: UIColor = UIColor.yellowColor()
    @IBInspectable var gridWidth: CGFloat = 2.0
    
    var grid = StandardEngine.sharedInstance.grid
    var xDim: CGFloat {return self.frame.width/CGFloat(grid.cols)}
    var yDim: CGFloat {return self.frame.height/CGFloat(grid.rows)}


    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
//        let grid = StandardEngine.sharedInstance.grid
        
//        var xDim: CGFloat {return self.frame.width/CGFloat(grid.cols)}
//        var yDim: CGFloat {return self.frame.height/CGFloat(grid.rows)}
        
        // Call for redraw of entire grid, one cell at a time
        for x in 0..<grid.cols {
            for y in 0..<grid.rows {
                //set rect for next cell
                let cellRect:CGRect = CGRectMake((xDim * CGFloat(x)), (yDim * CGFloat(y)), xDim, yDim)
                let currentCellState:CellState = grid[(x, y)]
                
                // Function call to draw cell
                self.drawCell(cellRect, cellState: currentCellState)
            }
        }
    }
    
    //  Function to take an array of cells (x,y) and draw grid with only those cells
    //  set to alive, all other cells set to empty
    func drawPoints (configuration: configData, rect: CGRect) -> (){
        
//        let maxElement = configuration.contents.reduce(configuration.contents[(0)]) {$0.0 < $0.1 ? $0.1 : $0.0}
//        print(maxElement)
        
        
        
        
//        pointGrid = configuration.contents.map() {return Cell.position = configuration.contents[0] ? $0.CellState = .Alive : $0.CellState = .Empty}
        
        // Check and fill grid with points
        
        for element in configuration.contents {
            let position = element
            let configCellState: CellState = .Alive
            grid[(position)] = configCellState
        }
        
        drawRect(rect)
    //  Close func drawPoints
    }
    
    func drawCell(rect: CGRect, cellState: CellState) -> (){
        var color = emptyColor
        print("drawing cell \(cellState)")
        
        switch cellState {
            case .Empty:  color = emptyColor
            case .Died:  color = diedColor
            case .Born:  color = bornColor
            case .Alive:  color = aliveColor
        }
        color.setFill()
                
        let path = UIBezierPath(ovalInRect: rect)
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
        
//        super.drawRect(rect)
        
    }
    
    //  Implement touch editing functionality
    
    func getCellPosition(position: CGPoint) -> Position {
        return Position(Int(position.y / bounds.height * CGFloat(grid.rows)), Int(position.x / bounds.height * CGFloat(grid.cols)))
    }
    
    func toggle(state: CellState) -> CellState {
        switch state {
        case .Alive, .Born: return .Empty
        default: return .Alive
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            let position = touch.locationInView(self)
            let cell = getCellPosition(position)
            grid[cell.row, cell.col] = toggle(grid[cell.row, cell.col])
            let rect = CGRectMake(CGFloat(cell.col)*xDim, CGFloat(cell.row)*yDim, xDim-1, yDim-1)
            setNeedsDisplayInRect(rect)
        }
    }

//  Close class definition of GridView
}
