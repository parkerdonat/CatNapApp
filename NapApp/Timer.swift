//
//  Timer.swift
//  NapApp
//
//  Created by Parker Donat on 4/12/16.
//  Copyright © 2016 Parker Donat. All rights reserved.
//

import Foundation

class Timer {
    
    var endDate: NSDate?
    var timeRemaining: NSTimeInterval {
        if let endDate = endDate {
            return endDate.timeIntervalSinceNow
        } else {
            return 20*60
        }
    }
    
    var isOn: Bool {
        if endDate == nil {
            return false
        } else {
            return true
        }
    }
    
    
}