//: Playground - noun: a place where people can play

import UIKit

var past = [[1,2,3,4,5], [11,12,13,14,15], [21,22,23,24,25]]

past[0]
past[1][3]
past[1][3] = 250
past





var present = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
//var present =[[Bool]]()


present
present[1][5]

var x = 1
var y = 5
present[x][y] = true
present
present[1][5]

print("Print Test Row \(x), Column \(y)")


for row in 0...9 {
    for column in 0...9 {
        if arc4random_uniform(3) == 1 {
            present[row][column] = true
        }
        else {
            present[row][column] = false
        }
    }
}

present


// instantiate array of boolean arrays for both before and after
var before = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
var after = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))


// initialize array
for row in 0...9 {
    for column in 0...9 {
        if arc4random_uniform(3) == 1 {
            before[row][column] = true
        }
        else {
            before[row][column] = false
        }
    }
}

before


//  Function to count lives in total array
func totalCount(inputArray:[[Bool]]) -> Int {
    var lifeCount = 0
    for row in 0...9 {
        for column in 0...9 {
            if inputArray[row][column] == true {
                lifeCount += 1
            }
        }
    }
    return lifeCount
}

totalCount(before)
totalCount(after)

var row = 8
var column = 9
var count = 0

before[(row+1)%10][(column-1)%10]
before[(row+1)%10][(column)%10]
before[(row+1)%10][(column+1)%10]
before[(row)%10][(column-1)%10]
before[(row)%10][(column+1)%10]
before[(row-1)%10][(column-1)%10]
before[(row-1)%10][(column)%10]
before[(row-1)%10][(column+1)%10]

if before[(row+1)%10][(column-1)%10] {count += 1}
if before[(row+1)%10][(column)%10] {count += 1}
if before[(row+1)%10][(column+1)%10] {count += 1}
if before[(row)%10][(column-1)%10] {count += 1}
if before[(row)%10][(column+1)%10] {count += 1}
if before[(row-1)%10][(column-1)%10] {count += 1}
if before[(row-1)%10][(column)%10] {count += 1}
if before[(row-1)%10][(column+1)%10] {count += 1}

count




//var currentCell = before[row][column]

var currentCell = false

switch currentCell {
case true:
    print("true")
case false:
    print("false")
}


count

switch count {
case 0..<2:
    after[row][column] = false
case 2:
    switch currentCell {
    case true:
        after[row][column] = true
    case false:
        after[row][column] = false
    }
case 3:
    after[row][column] = true
default:
    after[row][column] = false
}

count
currentCell
after[row][column]


//if count == 2,3 {
//    print("Count is \(count)")
//}

//switch currentCell {
//case true:
//    if count in 2...3 {
//        after[row][column] = true
//    }
//    else {
//        after[row][column] = false
//    }
//case false:
//    if neigborCount(row, column:column) == 3 {
//        after[row][column] = true
//    }
//    else {
//        after[row][column] = false
//    }
//}

after[row][column]


//func neighborCount(inputArray:[[Bool]], row:Int, column:Int) -> Int {
//    var aliveCount = 0
//    if inputArray[row+1][column-1] { aliveCount +=1 }
//    if inputArray[row+1][column] { aliveCount +=1 }
//    if inputArray[row+1][column+1] { aliveCount +=1 }
//    if inputArray[row][column-1] { aliveCount +=1 }
//    if inputArray[row][column+1] { aliveCount +=1 }
//    if inputArray[row-1][column-1] { aliveCount +=1 }
//    if inputArray[row-1][column] { aliveCount +=1 }
//    if inputArray[row-1][column+1] { aliveCount +=1 }
//    return aliveCount
//}
//
//neighborCount(before, row:2, column:3)


//
//
//var currentCell = false
//
//Switch currentCell {
//    case true:
//        if neighborCount(row, column:column) == 2, 3 {
//            after[row][column] = true
//        }
//        else {
//            after[row][column] = false
//        }
//    case false:
//        if neigborCount(row, column:column) == 3 {
//            after[row][column] = true
//        }
//        else {
//            after[row][column] = false
//        }
//
//    }

