//
//  Engine.swift
//  Assignment2
//
//  Created by David Cohron on 7/4/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import Foundation


// Function used as main logic for Problem 3

func step (inputArray:[[Bool]]) -> [[Bool]] {
    
    // instantiate new array of boolean arrays
    
    var newGeneration = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
    var neighborsAlive = 0
    var currentCell = false
    
    // Main logic for function step to iterate through each cell in an array
    
    for row in 0...9 {
        for column in 0...9 {
            
            // Function to count living cells in neigbors when passed array and subject cell row and column
            
            func hoodCount ( inputArray:[[Bool]], row:Int, column:Int) -> Int {
                var count = 0
                if inputArray[(row+1)%10][(column+9)%10] {count += 1}
                if inputArray[(row+1)%10][(column)%10] {count += 1}
                if inputArray[(row+1)%10][(column+1)%10] {count += 1}
                if inputArray[(row)%10][(column+9)%10] {count += 1}
                if inputArray[(row)%10][(column+1)%10] {count += 1}
                if inputArray[(row+9)%10][(column+9)%10] {count += 1}
                if inputArray[(row+9)%10][(column)%10] {count += 1}
                if inputArray[(row+9)%10][(column+1)%10] {count += 1}
                return count
            }
            
             // Function call to get number of living neighbors
            
            neighborsAlive = hoodCount(inputArray, row:row, column:column)
            
            currentCell = inputArray[row][column]
            
            // Set array after for one cell in each pass based on game logic switch on number of living neighbors
            
            switch neighborsAlive {
            case 0..<2:
                newGeneration[row][column] = false
            case 2:
                switch currentCell {
                case true:
                    newGeneration[row][column] = true
                case false:
                    newGeneration[row][column] = false
                }
            case 3:
                newGeneration[row][column] = true
            default:
                newGeneration[row][column] = false
            }
        }
    }
    
    return newGeneration
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

func livingNeighborsCount (neighborHood:[(Int, Int)], passedArray:[[Bool]]) -> Int {
    
    var count = 0
    var row = 0
    var column = 0
    
    for item in neighborHood {
        row = item.0
        column = item.1
        if passedArray[row][column] {count += 1}
    }
    return count
}



// Function call by Problem 4.  Repeat of problem 3 which invokes function neighbors instead of directly embedding that functionality

func step2 (inputArray:[[Bool]]) -> [[Bool]] {
    
    // instantiate new array of boolean arrays
    var newGeneration = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
    var neighborsAlive = 0
    var neighborHood = [(Int, Int)] ()
    var currentCell = false
    
    // Main logic for function looping through array before to set array after
    for row in 0...9 {
        for column in 0...9 {
            
            currentCell = inputArray[row][column]
            
            // Function call to neighbors which returns an array of 8 neighbors by row, column tuple
            
            neighborHood = neighbors((row, column))
            
            // Function call to livingNeighborsCount to get number of living neighbors
            
            neighborsAlive = livingNeighborsCount(neighborHood, passedArray: inputArray)
            
            // Set array after for one cell based on game logic switch on number of living neighbors
            
            switch neighborsAlive {
            case 0..<2:
                newGeneration[row][column] = false
            case 2:
                switch currentCell {
                case true:
                    newGeneration[row][column] = true
                case false:
                    newGeneration[row][column] = false
                }
            case 3:
                newGeneration[row][column] = true
            default:
                newGeneration[row][column] = false
            }
            
            
        }
    }
    
    return newGeneration
}

