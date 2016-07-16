//
//  Protocols.swift
//  Assignment4
//
//  Defines key elements including protocols and enum
//
//  Created by David Cohron on 7/15/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import Foundation

// Protocol for Grid
protocol GridProtocol {
    var rows: Int { get }
    var cols: Int { get }
    init(rows: Int, cols: Int)
    func neighbors(inputTuple: (Int, Int)) -> [(Int, Int)]
    subscript(row: Int, col: Int) -> CellState { get set }
}


//  Protocol for Engine Delegate
//  returns String???????
protocol EngineDelegate {
    func engineDidUpdate(withGrid: GridProtocol) -> String
}


// Protocol which sets up the engine type
protocol EngineProtocol {
    var delegate: EngineDelegate? { get set }
    var currentGrid: GridProtocol { get }
    var refreshRate: Double {get set}
    var refreshTimer: NSTimer {get set}
    var rows: UInt {get set}
    var cols: UInt {get set}
    func Init(rows: UInt, cols: UInt)-> GridProtocol
    func step() -> GridProtocol
}





// Problem #1
enum CellState: String {
    case Living
    case Empty
    case Born
    case Died
    
    
    func Description() -> String {
        return self.rawValue
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

