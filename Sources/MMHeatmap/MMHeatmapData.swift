//
//  MMHeatmapData.swift
//  Diarrrrrrrrrry
//
//  Created by Mac10 on 2021/04/13.
//  Copyright © 2021 s-n-1-0. All rights reserved.
//
import SwiftUI
public struct MMHeatmapData {
    var elapsedDay:Int
    var value:Int
}

public class MMHeatmapStyle:ObservableObject{
    init(baseCellColor:UIColor,minCellColor:UIColor = UIColor.secondarySystemBackground,week:[String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]) {
        self.minCellColor = minCellColor
        self.baseCellColor = baseCellColor
        self.week = week
    }
    @Published var minCellColor:UIColor
    @Published var baseCellColor:UIColor
    let week:[String]
}
