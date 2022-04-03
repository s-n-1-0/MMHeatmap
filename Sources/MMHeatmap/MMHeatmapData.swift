//
//  MMHeatmapData.swift
//  Diarrrrrrrrrry
//
//  Created by Mac10 on 2021/04/13.
//  Copyright © 2021 s-n-1-0. All rights reserved.
//
import SwiftUI

/**
 Input data
 */
public struct MMHeatmapData {
    public init(date _date:Date,value:Int){
        let date = _date.truncateHms()
        let comps = date.getYmdhms()!
        self.year = comps.year
        self.month = comps.month
        self.day = comps.day
        self.date = date
        self.value = value
    }
    public init(year:Int,month:Int,day:Int,value:Int){
        self.year = year
        self.month = month
        self.day = day
        self.date = Calendar(identifier: .gregorian).date(from: DateComponents(year:year,month: month,day: day))!
        self.value = value
    }
    let year:Int
    let month:Int
    let day:Int
    let date:Date
    
    public var value:Int
}
public struct MMHeatmapElapsedData{
    public init (elapsedDay:Int,value:Int){
        self.elapsedDay = elapsedDay
        self.value = value
    }
   public var elapsedDay:Int
   public var value:Int
}

public class MMHeatmapStyle:ObservableObject{
    public init(baseCellColor:UIColor,
                minCellColor:UIColor = UIColor.secondarySystemBackground,
                week:[String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],
                dateMMFormat:String = "MMM",
                clippedWithEndDate:Bool = true,
                isScroll:Bool = true) {
        self.minCellColor = minCellColor
        self.baseCellColor = baseCellColor
        self.week = week
        self.dateMMFormat = dateMMFormat
        self.clippedWithEndDate = clippedWithEndDate
        self.isScroll = isScroll
    }
    @Published public var minCellColor:UIColor
    @Published public var baseCellColor:UIColor
    let clippedWithEndDate:Bool
    let isScroll:Bool
    public let week:[String]
    public let dateMMFormat:String
}
