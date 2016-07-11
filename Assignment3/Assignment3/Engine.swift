//
//  Engine.swift
//  Assignment3
//
//  Created by David Cohron on 7/10/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import Foundation


// Problem 6
// Logic from Assignment 2
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

func livingNeighborsCount (neighborHood:[(Int, Int)], passedArray:[[CellState]]) -> Int {
    
    var count = 0
    var row = 0
    var column = 0
    
    for item in neighborHood {
        row = item.0
        column = item.1
        if (passedArray[row][column] == .Living) {count += 1}
        if (passedArray[row][column] == .Born) {count += 1}
    }
    return count
}



// Function call by View Controller. 
// Taken directly from Assignment 2 with change for the type of array passed in
// Invokes function neighbors instead of directly embedding that functionality

func step (inputArray:[[CellState]]) -> [[CellState]] {
        
    let rows = inputArray.count
    let columns = inputArray.count
    var newGeneration: [[CellState]] = Array(count: rows, repeatedValue: Array(count: columns, repeatedValue: .Empty))
    var neighborsAlive = 0
    var neighborHood = [(Int, Int)] ()
    var currentCellState: CellState = .Empty
    
    // Main logic for function looping through array before to set array after
    for row in 0...rows {
        for column in 0...columns {
            
            currentCellState = inputArray[row][column]
            
            // Function call to neighbors which returns an array of 8 neighbors by row, column tuple
            
            neighborHood = neighbors((row, column))
            
            // Function call to livingNeighborsCount to get number of living neighbors
            
            neighborsAlive = livingNeighborsCount(neighborHood, passedArray: inputArray)
            
            // Set array after for one cell based on game logic switch on number of living neighbors
            
            switch neighborsAlive {
            case 0..<2:
                switch currentCellState {
                case .Living, .Born:
                    newGeneration[row][column] = .Died
                case .Died, .Empty:
                    newGeneration[row][column] = .Empty
                }
            case 2:
                switch currentCellState {
                case .Living, .Born:
                    newGeneration[row][column] = .Living
                case .Died, .Empty:
                    newGeneration[row][column] = .Empty
                }
            case 3:
                switch currentCellState {
                case .Living, .Born:
                    newGeneration[row][column] = .Living
                case .Died:
                    newGeneration[row][column] = .Born
                case .Empty:
                    newGeneration[row][column] = .Empty
                }
            default:
                switch currentCellState {
                case .Living, .Born:
                    newGeneration[row][column] = .Died
                case .Died, .Empty:
                    newGeneration[row][column] = .Empty
                }

            }
            
            
        }
    }
    
    return newGeneration
}


