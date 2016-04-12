//
//  TimerController.swift
//  NapApp
//
//  Created by Parker Donat on 4/12/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import UIKit

class TimerController: NSObject {
    
    static let sharedInstance = TimerController()
    
    var timer = Timer()
    var localNotification: UILocalNotification?
    
    func startTimer() {
        // Check if tiemr is on. If not, then set time to 20 minutes and start countdown
        
        if timer.isOn == false {
            timer.endDate = NSDate(timeIntervalSinceNow: 0.25*60)
            secondTick()
            scheduleLocalNotification()
        }
    }
    
    func stopTimer() {
        // Check if it is on. If it is, then remove times's end date and stop countdown
        if timer.isOn {
            timer.endDate = nil
            performSelector(#selector(TimerController.cancelLocalNotification), withObject: nil, afterDelay: 10)
        }
    }
    
    func secondTick() {
        // Check to see if timeRemaining > 0. If so, send NSNotification to UI to update label. Otherwise, stop timer.
        if timer.timeRemaining > 0 {
            performSelector(#selector(TimerController.secondTick), withObject: nil, afterDelay: 1)
            NSNotificationCenter.defaultCenter().postNotificationName("secondTick", object: nil)
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName("timerCompleted", object: nil)
            stopTimer()
        }
    }
    
    func scheduleLocalNotification() {
         // Create local notification with same fire date as the timer
        localNotification = UILocalNotification()
        localNotification?.alertTitle = "Alert!"
        localNotification?.alertBody = "Wake up now!"
        localNotification?.fireDate = timer.endDate
        localNotification?.category = "notif"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification ?? UILocalNotification())
    }
    
    func cancelLocalNotification() {
        // Cancel the local notification if timer has been stopped
        UIApplication.sharedApplication().cancelLocalNotification(localNotification ?? UILocalNotification())
    }
    
    func timeAsString() -> String {
        // return a string represnting time remaining
        
        let timeRemaining = Int(timer.timeRemaining)
        let minutesLeft = timeRemaining / 60
        let secondsLeft = timeRemaining - (minutesLeft*60)
        
        return String(format: "%02d : %02d", arguments: [minutesLeft, secondsLeft])
    }
}