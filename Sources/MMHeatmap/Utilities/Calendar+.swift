//
//  Calendar.swift
//
//
//  Created by s-n-1-0 on 2024/03/30.
//

import Foundation
extension Calendar{
    /**
     Example:
     year: 2024, month: 3
     => Date[2024/3/31]
     */
    func lastDateOfMonth(year:Int,month:Int)->Date{
        var comp = DateComponents()
        comp.year = year
        comp.month = month + 1
        comp.day = 0
        // 0 = 前の月の最終日
        return self.date(from: comp)!
    }
    
    func monthRange(start:Date,end:Date)->Int{
        self.dateComponents([.month],
                            from: start.truncate([.year,.month]),
                            to:end.truncate([.year,.month])).month! + 1
        
    }
}
