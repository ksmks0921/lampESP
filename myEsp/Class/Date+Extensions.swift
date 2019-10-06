//
//  Date+Extensions.swift
//  myEsp
//
//  Created by ujs on 10/6/19.
//  Copyright © 2019 ksm. All rights reserved.
//

import Foundation
import UIKit
extension Date {
    static func calculateDate(day:Int, month:Int, year: Int, hour:Int, minute: Int)->Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let calculatedDate = formatter.date(from: "\(year)/\(month)/\(day) \(hour):\(minute)")
        return calculatedDate!
    }
    func getDayMonthYearHourMnuteSecond() -> (day:Int, month: Int, year: Int, hour: Int, minute: Int, second: Int){
        let calender = Calendar.current
        let day = calender.component(.day, from: self)
        let month = calender.component(.month, from: self)
        let year = calender.component(.year, from: self)
        let hour = calender.component(.hour, from: self)
        let minute = calender.component(.minute, from: self)
        let second = calender.component(.second, from: self)
        return (day, month, year, hour, minute, second)
        
        
        
    }
}
