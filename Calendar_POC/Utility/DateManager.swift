//
//  DateManager.swift
//  Calendar_POC
//
//  Created by aanchal on 06/03/18.
//  Copyright © 2018 aanchal. All rights reserved.
//

import UIKit

class DateManager: NSObject {

    var currentDate: Date?
    
    class func shared() -> DateManager {
        struct Static {
            static let sharedInstance = DateManager()
        }
        return Static.sharedInstance
    }
    
    override init() {
        super.init()
        var onceToken: Int = 0
        if (onceToken == 0) {
            currentDate = Date()
        }
        onceToken = 1
    }
    
    func setCurrentDate(_currentDate: Date) {
        currentDate = _currentDate
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DateManager.DateChanged"), object: currentDate)
    }
    
    func setThemes() {
        
    }
    
}
