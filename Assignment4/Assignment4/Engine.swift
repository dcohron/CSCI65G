//
//  Engine.swift
//  Assignment4
//
//  Created by David Cohron on 7/15/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import Foundation


////  Main Game Engine
//
//class StandardEngine: EngineProtocol {
//    var delegate: EngineDelegate?
//    func engineDidUpdate() -> [[Bool]] {
//        return [[false]]
//    }
//
//    var refreshRate: Double = 0.0
//    
//    var rows: UInt = 10 {
//        didSet {
//            if let delegate = delegate {
//                delegate.currentGrid(self, didUpdateRows: self.rows)
//            }
//        }
//    }
//
//    var cols: UInt = 10 {
//        didSet {
//            if let delegate = delegate {
//                delegate.currentGrid(self, didUpdateColumns: self.rows)
//            }
//        }
//
//
//
//
//    private var cellCount: UInt = {return rows * cols}
//    private var currentGrid : [CellState] =  Array<CellState>(count: cellCount, repeatedValue: .Empty)
//    subscript(row: UInt, col: UInt) -> CellState? {
//        get {
//            if row < 0 || row >= rows || col < 0 || col >= cols { return nil }
//            if currentGrid.count < Int(row*col) { return nil }
//            return currentGrid[Int(row * col + col)]
//        }
//        set (newValue) {
//            if newValue == nil { return }
//            if row < 0 || row >= rows || col < 0 || col >= cols { return }
//            currentGrid[Int(row*col + col)] = newValue!
//        }
//        }
//
//    internal var refreshTimer: NSTimer
//    
//    
//    func Init(rows: UInt, cols: UInt)-> [CellState] {
//        let cellCount: Int = Int(rows * cols)
//        let instanceOfGrid =  Array<CellState>(count: cellCount, repeatedValue: .Empty)
//        return instanceOfGrid
//    }
//    
//    
//    
//    func step (inputArray:GridProtocol) -> GridProtocol {
//        var newGeneration = Init(rows, cols: cols)
//        var neighborsAlive = 0
//        var neighborHood = [(Int, Int)] ()
//        var currentCellState: CellState = .Empty
//        
//        // Main logic for function looping through array before to set array after
//        for row in 0..<rows {
//            for column in 0..<cols {
//                
//                currentCellState = inputArray[row][column]
//                
//                // Function call to neighbors which returns an array of 8 neighbors by row, column tuple
//                
//                neighborHood = neighbors((row, column))
//                
//                // Function call to livingNeighborsCount to get number of living neighbors
//                
//                neighborsAlive = livingNeighborsCount(neighborHood, passedArray: inputArray)
//                
//                // Set array after for one cell based on game logic switch on number of living neighbors
//                
//                switch neighborsAlive {
//                case 0..<2:
//                    switch currentCellState {
//                    case .Living, .Born:
//                        newGeneration[row][column] = .Died
//                    case .Died, .Empty:
//                        newGeneration[row][column] = .Empty
//                    }
//                case 2:
//                    switch currentCellState {
//                    case .Living, .Born:
//                        newGeneration[row][column] = .Living
//                    case .Died, .Empty:
//                        newGeneration[row][column] = .Empty
//                    }
//                case 3:
//                    switch currentCellState {
//                    case .Living, .Born:
//                        newGeneration[row][column] = .Living
//                    case .Died:
//                        newGeneration[row][column] = .Born
//                    case .Empty:
//                        newGeneration[row][column] = .Empty
//                    }
//                default:
//                    switch currentCellState {
//                    case .Living, .Born:
//                        newGeneration[row][column] = .Died
//                    case .Died, .Empty:
//                        newGeneration[row][column] = .Empty
//                    }
//                    
//                }
//                
//                
//            }
//        }
//        
//        return newGeneration
//    }
//
//    
//    
//    // Function that takes and tuple (row, column) and returns an array of tuples for location of all neighbors.
//    
//    func neighbors (inputTuple: (Int, Int)) -> [(Int, Int)] {
//        var neighborArray = [(Int, Int)] ()
//        let row = inputTuple.0
//        let column = inputTuple.1
//        
//        neighborArray = [((row + 1)%10, (column + 9)%10)]
//        neighborArray.append((((row + 1)%10), column))
//        neighborArray.append((((row + 1)%10), ((column + 1)%10)))
//        neighborArray.append((row, ((column + 9)%10)))
//        neighborArray.append((row, ((column + 1)%10)))
//        neighborArray.append((((row + 9)%10), ((column + 9)%10)))
//        neighborArray.append((((row + 9)%10), column))
//        neighborArray.append((((row + 9)%10), ((column + 1)%10)))
//        
//        return neighborArray
//    }
//    
//    
//    
//    // Function to count living neighbors given array of neighbors
//    
//    func livingNeighborsCount (neighborHood:[(Int, Int)], passedArray: GridProtocol) -> Int {
//        
//        var count = 0
//        var row: Int = 0
//        var column: Int = 0
//        
//        for item in neighborHood {
//            row = item.0
//            column = item.1
//            if (passedArray[row][column] == .Living) {count += 1}
//            if (passedArray[row][column] == .Born) {count += 1}
//        }
//        return count
//    }
//
//    
//    
//    
//// Close class Standard Engine
//}

