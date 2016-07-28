//
//  ProjectPrototypeTests.swift
//  ProjectPrototypeTests
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import XCTest
@testable import ProjectPrototype

class ProjectPrototypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGliderEngine() {
        let engine = StandardEngine(6,6) { _ in .Empty }
        engine[3,0] = .Born
        engine[3,1] = .Born
        engine[3,2] = .Born
        engine[2,2] = .Born
        engine[1,1] = .Born
        
        var grid = engine.grid
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
    }
    
    func testRandomEngine() {
        let engine = StandardEngine(20,20) { _ in arc4random_uniform(3) == 1 ? .Alive : .Empty }
        var grid = engine.grid
        grid[5,10] = .Born
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")
        
        
        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")

        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")

        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")

        grid = engine.step()
        print("living: \(grid.living), born: \(grid.born), "
            + "alive: \(grid.alive), died: \(grid.died), empty: \(grid.empty)")

    }
}
