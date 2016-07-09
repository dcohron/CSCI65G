//
//  GridView.swift
//  Assignment3
//
//  Created by David Cohron on 7/8/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

@IBDesignable

class GridView: UIView {

    
    @IBInspectable var row: Int = 20 {
        didSet {
            self.grid = Array(count: row, repeatedValue: Array(count: column, repeatedValue: .Empty))
        }
    }
    @IBInspectable var column: Int = 20 {
        didSet {
            self.grid = Array(count: row, repeatedValue: Array(count: column, repeatedValue: .Empty))
        }
    }
    @IBInspectable var livingColor: UIColor = UIColor.yellowColor()
    @IBInspectable var emptyColor: UIColor = UIColor.whiteColor()
    @IBInspectable var bornColor: UIColor = UIColor.greenColor()
    @IBInspectable var diedColor: UIColor = UIColor.purpleColor()
    @IBInspectable var gridWidth: CGFloat = 200.0
    
    var grid: [[CellState]] = [[]]
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

