//: Playground - noun: a place where people can play

import UIKit


// Dictionary and Array

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
// occupations["Jayne"] = "Public Relations”

shoppingList
occupations


// Control Flow

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
teamScore


//  Optionals

var optionalString: String?="Hello"
print(optionalString == nil)

var optionalName: String? = nil
var greeting = "Hello"
if let name = optionalName {
    greeting = "Hello, \(name)"
} else {
    greeting = "Hello you old son of a gun"
}

let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"


// Switches

let vegetable = "red pepper"
var vegetableComment = ""
switch vegetable {
case "celery":
    var vegetableComment = "Add some raisins and make ants on a log."
case "cucumber", "watercress":
    var vegetableComment = "That would make a good tea sandwich."
case let x where x.hasSuffix("pepper"):
    var vegetableComment = "Is it a spicy \(x)?"
default:
    var vegetableComment = "Everything tastes good in soup."
}
//  vegetableComment does not exist outside of switch statement.  It is a local variable in the Switch
vegetableComment


// Nested Loops

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
largest


// Functions and Closures

func greet(name: String, day: String, sod: String) -> String {
    return "Hello \(name), today is \(day) and the special of the day is \(sod)."
}
greet("Bob", day:"Tuesday", sod:"Macaroni and Cheese")


func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}
let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)


var numbers = [1, 2, 3]

numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})
// Does same as below

numbers = [2, 4, 6]

let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
//  Does same as above

let maxValue = Int.max
let minValue = Int.min
var minHalf = minValue/2

