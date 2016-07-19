// Playground - noun: a place where people can play

import Foundation
import UIKit
import CoreGraphics
import QuartzCore
import Section05Views

let rect = CGRectMake(0, 0, 300, 300)

var graphData = [
    ["label" : "Mon",   "value" : NSNumber(int:15)],
    ["label" : "Tues",  "value" : NSNumber(int:30)],
    ["label" : "Weds",  "value" : NSNumber(int:7)],
    ["label" : "Thurs", "value" : NSNumber(int:60)],
    ["label" : "Fri",   "value" : NSNumber(int:30)],
    ["label" : "Sat",   "value" : NSNumber(int:15)],
    ["label" : "Sun",   "value" : NSNumber(int:45)]
    ] as [[String:AnyObject]]

var graphView = GraphView(frame:rect, data:graphData)

graphData = [
    ["label" : "Mon",   "value" : NSNumber(int:4)],
    ["label" : "Tues",  "value" : NSNumber(int:20)],
    ["label" : "Weds",  "value" : NSNumber(int:4)],
    ["label" : "Thurs", "value" : NSNumber(int:6)],
    ["label" : "Fri",   "value" : NSNumber(int:2)],
    ["label" : "Sat",   "value" : NSNumber(int:8)],
    ["label" : "Sun",   "value" : NSNumber(int:0)]
    ] as [[String:AnyObject]]

graphView.data = graphData

