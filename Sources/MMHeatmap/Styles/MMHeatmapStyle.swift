//
//  MMHeatmapStyle.swift
//  
//
//  Created by s-n-1-0 on 2023/10/29.
//

import SwiftUI
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
