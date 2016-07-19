//: Playground - noun: a place where people can play

import UIKit


// Enum defines our own type/limited or defined set, value type => pass by copy

enum State {
    case Busy
    case Waiting
    case Running
}

class TaskManager {
    var happy:Bool = false
    var state:State = .Busy
    var state2 = State.Busy
}


enum State:String {
    case Busy = "Busy"
    case Waiting = "Waiting"
    case Running = "Running"
}


enum Action {
    case Sleep (time:Int)
    case Run (length:Float)
}

class Person {
    let name
    
    func handleAction (action:Action) {
        switch action {
        case.Sleep(let time)
        case.Run(let length)
        }
    }
}


enum CellState:String {
    case Living = "Li   ving"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    
}