//
//  Engine.swift
//  Assignment4
//
//  Created by David Cohron on 7/15/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import Foundation

//
//// Protocol which sets up the engine type
//protocol EngineProtocol {
//    var delegate: EngineDelegate? { get set }
//    var grid: GridProtocol { get }
//    var refreshRate: Double {get set}
//    var refreshTimer: NSTimer {get set}
//    var rows: Int {get set}
//    var cols: Int {get set}
//    init(rows: Int, cols: Int)
//    func step() -> GridProtocol
//}



//  Main Game Engine

class StandardEngine: EngineProtocol {
    
    private static var _sharedInstance = StandardEngine()
    static var sharedInstance: StandardEngine {
        get {
            return _sharedInstance
        }
    }
    
    var delegate: EngineDelegate? {
        get {
            return self.delegate
        }
        set (newValue) {
            self.delegate = newValue
            return
        }
    }
    
    var grid:Grid {return self.grid}
    
    
    var rows:Int=10 {
        didSet {
            if let delegate = delegate {
                delegate.currentGrid(self, didUpdateRows: self.rows)
            }
        }
    }

    var cols:Int=10 {
        didSet {
            if let delegate = delegate {
                delegate.currentGrid(self, didUpdateColumns: self.rows)
            }
        }
    }

    private var refreshTimer: NSTimer?
    
    var refreshRate: Double = 0.0 {
        didSet {
            if refreshRate != 0.0 {
                if let timer = refreshTimer { timer.invalidate() }
                let sel = #selector(StandardEngine.timerDidFire(_:))
                refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate,
                                                               target: self,
                                                               selector: sel,
                                                               userInfo: ["name": "fred"],
                                                               repeats: true)
            }
            else if let timer = refreshTimer {
                timer.invalidate()
                self.refreshTimer = nil
            }
        }
    }



//    private var cellCount: Int = {return rows * cols}
    var currentGrid: Grid = []
    
    
    required init(rows: Int, cols: Int) {
        _ =  Grid(rows: rows, cols: cols)
    }
    
    
    
    func step (inputArray:Grid) -> Grid {
        let newGeneration:Grid
        var neighborsAlive = 0
        var neighborHood = [(Int, Int)] ()
        var currentCellState: CellState = .Empty
        
        // Main logic for function looping through array before to set array after
        for row in 0..<inputArray.rows {
            for column in 0..<inputArray.cols {
                
                currentCellState = inputArray[row, column]
                
                // Function call to neighbors which returns an array of 8 neighbors by row, column tuple
                neighborHood = inputArray.neighbors((row, column))
                
                // Function call to livingNeighborsCount to get number of living neighbors
                neighborsAlive = inputArray.livingNeighborsCount(neighborHood, passedArray: inputArray)
                
                // Set nextGeneration array for one cell based on game logic switch on number of living neighbors
                switch neighborsAlive {
                case 0..<2:
                    switch currentCellState {
                    case .Living, .Born:
                        newGeneration[row, column] = .Died
                    case .Died, .Empty:
                        newGeneration[row, column] = .Empty
                    }
                case 2:
                    switch currentCellState {
                    case .Living, .Born:
                        newGeneration[row, column] = .Living
                    case .Died, .Empty:
                        newGeneration[row, column] = .Empty
                    }
                case 3:
                    switch currentCellState {
                    case .Living, .Born:
                        newGeneration[row, column] = .Living
                    case .Died:
                        newGeneration[row, column] = .Born
                    case .Empty:
                        newGeneration[row, column] = .Empty
                    }
                default:
                    switch currentCellState {
                    case .Living, .Born:
                        newGeneration[row, column] = .Died
                    case .Died, .Empty:
                        newGeneration[row, column] = .Empty
                    }
                    
                }
                
                
            }
        }
        
        return newGeneration
    }

    
    func engineDidUpdate() -> [[Bool]] {
        return [[false]]
    }
    
    
    @objc func timerDidFire(timer:NSTimer) {
        self.rows += 1
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "ExampleNotification",
                               object: nil,
                               userInfo: ["name": "fred"])
        center.postNotification(n)
        print ("\(timer.userInfo?["name"] ?? "not fred")")
    }

    
// Close class Standard Engine
}

