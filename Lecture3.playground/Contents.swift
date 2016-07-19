//: Playground - noun: a place where people can play

import Foundation

let immutableString = "hello, playground"
var str = "Hello, playground"

str = "another string"

var myInt = 42
let myConstant = 50

let implicitDouble = 70.0
let explicitDouble: Double = 70

let label = "the width is "
let width = 94
let widthlabel = label + String(width)
String(94)
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let orangeSummary = "I have \(oranges) oranges."

var aFloat : Float

var shoppingList: Array<Any> = ["catfish", "water", "tulips", "blue paint", 47]
var copyList = shoppingList

shoppingList.append("toothpaste")
shoppingList.append(47)
shoppingList = shoppingList + shoppingList

copyList

var occupation: Dictionary<String, String> = [
    "malcom": "captain",
    "kaylee": "mechanic",
]

occupation["Jayne"] = "Public Relations"

var occupationNames = occupation.map{ (k:String, v:String) -> String in
    return k
}

occupationNames

var occupationNames2 = occupation.map{return $0.0}
var occupationNames3 = occupation.map{$0.0}

occupationNames2
occupationNames3


var r = 50...100
var g = r.generate()
g.next()
g.next()

var g1 = [11, 21, 31, 41, 51].generate()
g1.next()


var tuple1 = (1,2)
tuple1.0
tuple1.1

var tuple2 = (first:"Van", last:"Simmons")
tuple2.0
tuple2.last

for (k,v) in occupation {
    print("\(k),\(v)")
}

func doubler(x:Int) -> Int {
    return x*2
}

doubler(4)

func progression(v:Int, f:Int->Int) -> Int{
    return f(v)
}

progression(4, f:doubler)

var tf = false
tf = true

var arrArr = [[true]]
var arrArr2:Array<Array<Bool>> = [[false]]
var arrArr3:Array<Dictionary<Int, Bool>> = [[1:true]]

var closure = { (x:Int) -> Int in
    return x*2
}

progression(6,f:closure)
closure(6)

var optionalN:Int? = nil
var implicitOptionalN:Int! = 12

if let n = optionalN {
    let doubleN = doubler(n)
}

doubler(implicitOptionalN)


    