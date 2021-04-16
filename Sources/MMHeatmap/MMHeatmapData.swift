//
//  MMHeatmapData.swift
//  Diarrrrrrrrrry
//
//  Created by Mac10 on 2021/04/13.
//  Copyright © 2021 s-n-1-0. All rights reserved.
//
import SwiftUI
public struct MMHeatmapData {
    public init (elapsedDay:Int,value:Int){
        self.elapsedDay = elapsedDay
        self.value = value
    }
   public var elapsedDay:Int
   public var value:Int
}

public class MMHeatmapStyle:ObservableObject{
    public init(baseCellColor:UIColor,minCellColor:UIColor = UIColor.secondarySystemBackground,week:[String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]) {
        self.minCellColor = minCellColor
        self.baseCellColor = baseCellColor
        self.week = week
    }
    @Published public var minCellColor:UIColor
    @Published public var baseCellColor:UIColor
   public let week:[String]
}
