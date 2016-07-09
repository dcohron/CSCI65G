//
//  ViewController.swift
//  FLO
//
//  Created by David Cohron on 7/8/16.
//  Copyright © 2016 Trident Advisors. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isGraphViewShowing = false
    
    //Counter outlets
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    //Container and Graph view outlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var graphView: GraphView!
    
    //Label outlets
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!

    override func viewDidLoad() {
        
        counterLabel.text = String(counterView.counter)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPushButton(button: PushButtonView) {
        if button.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        
        if isGraphViewShowing {
            counterViewTap(nil)
        }
    }
    
    @IBAction func counterViewTap(gesture:UITapGestureRecognizer?) {
        if (isGraphViewShowing) {
            
            //hide Graph
            UIView.transitionFromView(graphView,
                                      toView: counterView,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromLeft,
                                        UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion:nil)
        } else {
            
            //show Graph
            setupGraphDisplay()
            UIView.transitionFromView(counterView,
                                      toView: graphView,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromRight,
                                        UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    
    func setupGraphDisplay() {
        
        //Use 7 days for graph - can use any number,
        //but labels and sample data are set up for 7 days
//        let noOfDays:Int = 7
        
        //1 - replace last day with today's actual data
        graphView.graphPoints[graphView.graphPoints.count-1] = counterView.counter
        
        //2 - indicate that the graph needs to be redrawn
        graphView.setNeedsDisplay()
        
        maxLabel.text = "\(graphView.graphPoints.maxElement()!)"
        
        //3 - calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0, combine: +)
            / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
        //set up labels
        //day of week labels are set up in storyboard with tags
        //today is last day of the array need to go backwards
        
        //4 - get today's day number
//        let dateFormatter = NSDateFormatter()
//        let calendar = NSCalendar.currentCalendar()
//        let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
//        let componentOptions:NSCalendarUnit = Weekday
//        let components = calendar.components(componentOptions,
//                                             fromDate: NSDate())
//        var weekday = components.weekday
//        
//        let days = ["S", "S", "M", "T", "W", "T", "F"]
//        
//        //5 - set up the day name labels with correct day
//        let reverseDays = days.reverse()
//        for i in reverseDays(1...days.count) {
//            if let labelView = graphView.viewWithTag(i) as? UILabel {
//                if weekday == 7 {
//                    weekday = 0
//                }
//                labelView.text = days[weekday--]
//                if weekday < 0 {
//                    weekday = days.count - 1
//                }
//            }
//        }
    }
    
    

}

