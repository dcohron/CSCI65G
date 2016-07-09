//
//  ViewController.swift
//  Assignment3
//
//  Created by David Cohron on 7/8/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    

}

