//
//  Engine.swift
//  Assignment2
//
//  Created by David Cohron on 7/4/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import Foundation


func step (inputArray:[[Bool]]) -> [[Bool]] {
    
    // instantiate new array of boolean arrays
    var newGeneration = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
    var neighborsAlive = 0
    var currentCell = false
    
    // Main logic for function
    for row in 0...9 {
        for column in 0...9 {
            
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
            
            neighborsAlive = hoodCount(inputArray, row:row, column:column)
            
            currentCell = inputArray[row][column]
            
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




// function that takes and tuple (row, column) and returns an array of tuples for location of all neighbors.

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


// Repeat of problem 3 which invokes function neighbors instead of directly embedding that functionality

func step2 (inputArray:[[Bool]]) -> [[Bool]] {
    
    // instantiate new array of boolean arrays
    var newGeneration = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
    var neighborsAlive = 0
    var neighborHood = [(Int, Int)] ()
    var currentCell = false
    
    // Main logic for function
    for row in 0...9 {
        for column in 0...9 {
            
            currentCell = inputArray[row][column]
            
            neighborHood = neighbors((row, column))
            
            neighborsAlive = livingNeighborsCount(neighborHood, passedArray: inputArray)
            
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

