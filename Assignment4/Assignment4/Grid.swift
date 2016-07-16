//
//  Grid.swift
//  Assignment4
//
//  Created by David Cohron on 7/16/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import Foundation


class Grid: GridProtocol {
    
    var rows: Int {return self.rows }
    var cols: Int { return self.cols }
    var grid: [CellState]
    
    required init(rows: Int, cols: Int) {
//        let row = self.rows
//        let col = self.cols
        grid = Array(count: rows * cols, repeatedValue: .Empty)
    }
    
    subscript(row: Int, col: Int) -> CellState {
        get {
            assert(indexIsValidForRow(row, column: col), "Index out of range")
            return grid[(row * col + col)]
        }
        set {
            assert(indexIsValidForRow(row, column: col), "Index out of range")
            grid[(row*col) + col] = newValue
        }
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < cols
    }

    
    // Function that takes and tuple (row, column) and returns an array of tuples for location of all neighbors.
    func neighbors (inputTuple: (Int, Int)) -> [(Int, Int)] {
        var neighborArray = [(Int, Int)] ()
        let row = inputTuple.0
        let column = inputTuple.1
        
        neighborArray = [((row + 1)%10, (column + 9)%10)]
        neighborArray.append((((row + 1)%10), column))
        neighborArray.append((((row + 1)%10), ((column + 1)%10)))
        neighborArray.append((row, ((column + 9)%10)))
        neighborArray.append((row, ((column + 1)%10)))
        neighborArray.append((((row + 9)%10), ((column + 9)%10)))
        neighborArray.append((((row + 9)%10), column))
        neighborArray.append((((row + 9)%10), ((column + 1)%10)))
        
        return neighborArray
    }
    
    
    
    // Function to count living neighbors given array of neighbors
    func livingNeighborsCount (neighborHood:[(Int, Int)], passedArray: Grid) -> Int {
        
        var count = 0
        var row: Int = 0
        var column: Int = 0
        
        for item in neighborHood {
            row = item.0
            column = item.1
            if (passedArray[row, column] == .Living) {count += 1}
            if (passedArray[row, column] == .Born) {count += 1}
        }
        return count
    }

    

// Close class Grid
}

