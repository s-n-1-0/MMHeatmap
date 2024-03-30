//
//  MMHeatmapLayout.swift
//  
//
//  Created by s-n-1-0 on 2023/10/29.
//

import SwiftUI
class MMHeatmapLayout:ObservableObject{
    let cellSize:CGFloat = 10
    let cellSpacing:CGFloat = 2
    let mmLabelHeight:CGFloat = 20
    let mmLabelVSpacing:CGFloat = 8
    var columnHeight:CGFloat{
        get{
            cellSize * 7 + cellSpacing * 6
        }
    }
    
    var mmHeatmapViewHeight:CGFloat{
        get{
            columnHeight + mmLabelHeight + mmLabelVSpacing
        }
    }
    
    var dividerWidth:CGFloat{
        get{
            cellSize*2
        }
    }
    
    func calcMMHeatmapMonthViewWidth(year:Int,month:Int)->CGFloat{
        let calendar = Calendar(identifier: .gregorian)
        let lastDate = calendar.lastDateOfMonth(year: year, month: month)
        let weeks = calendar.component(.weekOfMonth, from: lastDate)
        return CGFloat(weeks) * cellSize + CGFloat(weeks - 1) * cellSpacing
    }
    
    func calcMMHeatmapViewContentWidth(start:Date,end:Date)->CGFloat{
        let calender = Calendar(identifier: .gregorian)
        let monthRange = calender.monthRange(start: start, end: end)
        let startYear = calender.component(.year, from: start)
        let startMonth = calender.component(.month, from: start)
        let months = startMonth ..< (startMonth + monthRange)
        let sumWidth = months.enumerated().map{
            i, m in
            calcMMHeatmapMonthViewWidth(year: startYear, month: m)
            + (i < months.count - 1 ?  dividerWidth: 0)
        }.reduce(0, +)
        return sumWidth
    }
}
