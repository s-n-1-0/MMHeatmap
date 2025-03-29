//
//  Date.swift
//  
//
//  Created by Mac10 on 2022/04/01.
//

import Foundation

extension Date{
    func truncate(_ comps:Set<Calendar.Component>)->Date{
        let cal = Calendar(identifier: .gregorian)
        let comps = cal.dateComponents(comps, from: self)
        return cal.date(from: comps)!
    }
    
    func truncateHms() -> Date{
        truncate([.year, .month, .day])
    }
    
    func getYmdhms() -> Ymdhms?{
        let cal = Calendar(identifier: .gregorian)
        let comps = cal.dateComponents(
            [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day,
             Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second],
            from: self)
        if let year = comps.year, let month = comps.month, let day = comps.day, let hour = comps.hour, let minute = comps.minute, let second = comps.second{
            return Ymdhms(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        }
        return nil
    }
    struct Ymdhms{
        let year:Int
        let month:Int
        let day:Int
        let hour:Int
        let minute:Int
        let second:Int
    }
}
