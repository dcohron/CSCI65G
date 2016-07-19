//
//  AppDelegate.swift
//  Section05
//
//  Created by Van Simmons on 2/15/15.
//  Copyright (c) 2015 ComputeCycles, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var workerThread:NSThread! = nil
    var shouldStopBackgroundThread = false

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        NSThread.detachNewThreadSelector("startWorkerThread", toTarget: self, withObject: nil)

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    class ThreadDispatch:NSObject {
        private var threadBlock:() -> Void
        init(block: () -> Void) {
            threadBlock = block
            super.init()
        }
        func threadWrapper()
        {
            threadBlock()
        }
    }
    
    func dispatchToWorkerThread(block:() -> Void) {
        synchronized(self) {
            var td = ThreadDispatch(block: block)
            NSObject.performSelector("threadWrapper", onThread: self.workerThread,
                withObject: td, waitUntilDone: false, modes: NSArray(object:NSRunLoopCommonModes) as [AnyObject])
        }
    }
    
    func startWorkerThread()
    {
        autoreleasepool {
            let localRunLoop = NSRunLoop.currentRunLoop()
            var localThreadTimer:NSTimer!
            
            synchronized(self) {
                self.workerThread = NSThread.currentThread()
                self.workerThread.name = "NSS Worker"
                
                // make sure that there is at least one timer on the run loop
                // so that this will wake up and we can decide whether or not
                // to continue
                if NSThread.currentThread() != NSThread.mainThread() {
                    localThreadTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,
                        target: self, selector: "handleTimer:", userInfo: nil, repeats: true)
                }
            }
            while self.shouldStopBackgroundThread == false {
                autoreleasepool {
                    let date = NSDate().dateByAddingTimeInterval(1.0)
                    localRunLoop.runMode(NSDefaultRunLoopMode, beforeDate: date)
                }
            }
            localThreadTimer.invalidate()
        }
    }
    
    func handleTimer(timer:NSTimer) {
        
    }
}

