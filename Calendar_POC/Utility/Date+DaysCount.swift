//
//  Date+DaysCount.swift
//  Calendar
//
//  Created by Aanchal Nigam on 04/03/18.
//  Copyright © 2018 v2solutions. All rights reserved.
//

import Foundation

let dictWeekNumberName = [1: "Sunday", 2: "Monday", 3: "Tuesday", 4: "Wednesday", 5: "Thursday", 6: "Friday", 7: "Saturday"]
let arrayWeekAbrev = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
let arrayMonthName = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
let arrayMonthNameAbrev = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

extension Date {
    
    func lastDayOfMonth() -> Date {
        let dayCount: Int = numberOfDaysInMonthCount()
        var calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        if let aName = NSTimeZone(name: "GMT") {
            calendar.timeZone = aName as TimeZone
        }
        var comp: DateComponents? = calendar.dateComponents([.year, .month, .day], from: self)
        comp?.day = dayCount
        return (calendar.date(from: comp!))!
    }
    
    func numberOfDaysInMonthCount() -> Int {
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let dayRange: Range? = calendar.range(of: .day, in: .month, for: self)
        return dayRange?.count ?? 0
    }
    
    func numberOfWeekInMonthCount() -> Int {
        let calender = Calendar.current
        let weekRange: Range? = calender.range(of: .weekday, in: .month , for: self)
        return weekRange?.count ?? 0
    }
    
    func componentsOfDate() -> DateComponents {
        return Calendar.current.dateComponents([.day, .month, .year, .weekday, .hour, .minute], from: self)
    }
    
    // MARK: - Methods Statics
    static func componentsOfCurrentDate() -> DateComponents {
        return Date.componentsOf(date: Date())
    }
    
    static func componentsOf(date: Date) -> DateComponents {
        return Calendar.current.dateComponents([.day, .month, .year, .weekday, .weekOfMonth, .hour, .minute], from: date)
    }
    
    static func dateWithYear(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let components: DateComponents? = Date.componentsWithYear(year: year, month: month, day: day)
        return (calendar.date(from: components!))!
    }
    
    static func dateWithHour(hour: Int, min: Int) -> Date {
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let components: DateComponents? = Date.componentsWithHour(hour: hour, min: min)
        return (calendar.date(from: components!))!
    }
    
    static func stringTimeOfDate(_ date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm"
        return dateFormater.string(from: date)
    }
    
    static func stringDayOfDate(_ date: Date) -> String {
        let comp: DateComponents? = Date.componentsOf(date: date)
        return "\(String(describing: dictWeekNumberName[(comp?.weekday)!])), \(arrayMonthNameAbrev[(comp?.month)! - 1]) \(String(describing: comp?.day)), \(String(describing: comp?.year))"
    }
    
    static func componentsWithYear(year: Int, month: Int, day: Int) -> DateComponents {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return components
    }
    
    static func componentsWithHour(hour: Int, min: Int) -> DateComponents {
        var components = DateComponents()
        components.hour = hour
        components.minute = min
        return components
    }
    
    static func isTheSameDateTheCompA(_ compA: DateComponents, compB: DateComponents) -> Bool {
        return compA.day == compB.day && compA.month == compB.month && compA.year == compB.year
    }
    
    static func isTheSameTimeTheCompA(_ compA: DateComponents, compB: DateComponents) -> Bool {
        return compA.hour == compB.hour && compA.minute == compB.minute
    }

}

