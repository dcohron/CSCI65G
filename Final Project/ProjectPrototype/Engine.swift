//
//  Engine.swift
//  FinalProject
//
//  Created by Nick Cohron on 7/28/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//


import UIKit

typealias Position = (row:Int, col: Int)

enum CellState {
    case Empty
    case Died
    case Born
    case Alive
    
    func isLiving() -> Bool {
        switch self {
        case .Alive, .Born: return true
        case .Died, .Empty: return false
        }
    }
    
    func toggle(value:CellState) -> CellState {
        switch value {
        case .Empty, .Died:
            return .Alive
        case .Alive, .Born:
            return .Empty
        }
    }
}

typealias Cell = (position: Position, state: CellState)

protocol GridProtocol {
    var rows: Int { get }
    var cols: Int { get }
    var cells: [Cell] { get set }
    
    var living: Int { get }
    var dead:   Int { get }
    var alive:  Int { get }
    var born:   Int { get }
    var died:   Int { get }
    var empty:  Int { get }
    
    subscript (i:Int, j:Int) -> CellState { get set }
    
    func neighbors(pos: Position) -> [Position]
    func livingNeighbors(position: Position) -> Int
}

protocol EngineDelegate: class {
    func engineDidUpdate(withGrid: GridProtocol)
    func engineDidUpdate(withConfigurations: Array<Configuration>)
}

extension EngineDelegate {
    func engineDidUpdate(withConfigurations: Array<Configuration>) {
        // empty default implementation
    }
}

protocol EngineProtocol {
    var rows: Int { get set }
    var cols: Int { get set }
    var grid: GridProtocol { get }
    weak var delegate: EngineDelegate? { get set }
    
    var refreshRate:  Double { get set }
    var refreshTimer: NSTimer? { get set }
    
    func step() -> GridProtocol
}

typealias CellInitializer = (Position) -> CellState

class StandardEngine: EngineProtocol {
    
    private static var _sharedInstance: StandardEngine = StandardEngine(20,20)
    static var sharedInstance: StandardEngine { get { return _sharedInstance } }
    
    //  Generation count to count how many steps from original (seed) input grid
    var genCount = 0
    
    // Configurations Array (here because multiple views can add to it and read it)
    var configurationIndex: Int?
    var configuration: Configuration? {
        get {
            if delegate is ConfigurationEditorViewController {
                return configurations[configurationIndex!]
            }
            return nil
        }
        set {
            if delegate is ConfigurationEditorViewController {
                configurations[configurationIndex!] = newValue!
            }
        }
    }
    var configurations:Array<Configuration> = [] {
        didSet {
            if let delegate = self.delegate { delegate.engineDidUpdate(self.configurations) }
        }
    }
    
    func loadConfigurations(urlString: String) {
        let url = NSURL(string: urlString)!
        let fetcher = Fetcher()
        fetcher.requestJSON(url) { (json, message) in
            if let json = json, array = json as? Array<Dictionary<String,AnyObject>> {
                let op = NSBlockOperation {
                    self.configurations = array.map({ (dict) -> Configuration in
                        return Configuration.fromJSON(dict)
                    })
                    
                }
                NSOperationQueue.mainQueue().addOperation(op)
            }
        }
    }
    
    // Called from Configuration Editor Load button
    func updateGridBasedOnConfiguration() {
        if let configuration = configuration {
            let newGrid = Grid(rows, cols) { position in
                return configuration.positions.contains({ return position.row == $0.row && position.col == $0.col }) ? .Alive : .Empty
            }
            grid = newGrid
            genCount = 0
        }
    }
    
    // Called from Simulation view save button
    func addConfigurationBasedOnGrid(name: String) {
        let configName = name
        print("Let the name be \(configName)")
        var positions = Array<Position>()
        positions = grid.cells.reduce([]) { (array, cell) -> Array<Position> in
            if cell.state.isLiving() {
                return array + [cell.position]
            }
            else {
                return array
            }
        }
        print("The name is \(configName)")
        configurations.append(Configuration(title: configName, positions: positions))
    }
    
    
    
    var grid: GridProtocol
    
    var rows: Int = 20 {
        didSet {
            grid = Grid(self.rows, self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    var cols: Int = 20 {
        didSet {
            grid = Grid(self.rows, self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    weak var delegate: EngineDelegate?
    
    var refreshRate:  Double = 1.0
    var refreshTimer: NSTimer?
    var timerOn: Bool = true
    
    /// Cancel the timer
    func cancelTimer() {
        print("Canceling")
        refreshTimer?.invalidate()
        refreshTimer = nil
    }

    /// Start timer
    func startTimer() {
        // Invalidate any old one in case it was called more than once
        refreshTimer?.invalidate()
        
        // Set up the timer
        refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate,
                                                       target: self,
                                                       selector: #selector(onTimerFire(_:)),
                                                       userInfo: nil,
                                                       repeats: true)

        }

    @objc func onTimerFire(timer:NSTimer) {
        self.step()
        print("Fired and Stepped")
    }
    
    
    subscript (i:Int, j:Int) -> CellState {
        get {
            return grid.cells[i*cols+j].state
        }
        set {
            grid.cells[i*cols+j].state = newValue
        }
    }
    
    
    
    private init(_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        self.rows = rows
        self.cols = cols
        self.grid = Grid(rows,cols, cellInitializer: cellInitializer)
    }
    
    func step() -> GridProtocol {
        genCount = genCount + 1
        var newGrid = Grid(self.rows, self.cols)
        newGrid.cells = grid.cells.map {
            switch grid.livingNeighbors($0.position) {
            case 2 where $0.state.isLiving(),
            3 where $0.state.isLiving():  return Cell($0.position, .Alive)
            case 3 where !$0.state.isLiving(): return Cell($0.position, .Born)
            case _ where $0.state.isLiving():  return Cell($0.position, .Died)
            default:                           return Cell($0.position, .Empty)
            }
        }
        grid = newGrid
        if let delegate = delegate { delegate.engineDidUpdate(grid) }
        return grid
    }
}

struct Grid: GridProtocol {
    private(set) var rows: Int
    private(set) var cols: Int
    var cells: [Cell]
    
    var living: Int { return cells.reduce(0) { return  $1.state.isLiving() ?  $0 + 1 : $0 } }
    var dead:   Int { return cells.reduce(0) { return !$1.state.isLiving() ?  $0 + 1 : $0 } }
    var alive:  Int { return cells.reduce(0) { return  $1.state == .Alive  ?  $0 + 1 : $0 } }
    var born:   Int { return cells.reduce(0) { return  $1.state == .Born   ?  $0 + 1 : $0 } }
    var died:   Int { return cells.reduce(0) { return  $1.state == .Died   ?  $0 + 1 : $0 } }
    var empty:  Int { return cells.reduce(0) { return  $1.state == .Empty  ?  $0 + 1 : $0 } }
    
    init (_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        self.rows = rows
        self.cols = cols
        self.cells = (0..<rows*cols).map {
            let pos = Position($0/cols, $0%cols)
            return Cell(pos, cellInitializer(pos))
        }
    }
    
    subscript (i:Int, j:Int) -> CellState {
        get {
            return cells[i*cols+j].state
        }
        set {
            cells[i*cols+j].state = newValue
        }
    }
    
    private static let offsets:[Position] = [
        (-1, -1), (-1, 0), (-1, 1),
        ( 0, -1),          ( 0, 1),
        ( 1, -1), ( 1, 0), ( 1, 1)
    ]
    func neighbors(pos: Position) -> [Position] {
        return Grid.offsets.map { Position((pos.row + rows + $0.row) % rows,
            (pos.col + cols + $0.col) % cols) }
    }
    
    func livingNeighbors(position: Position) -> Int {
        return neighbors(position)
            .reduce(0) {
                self[$1.row,$1.col].isLiving() ? $0 + 1 : $0
        }
    }
}
