//
//  MMHeatmapView.swift
//  Diarrrrrrrrrry
//
//  Created by Mac10 on 2021/04/13.
//  Copyright © 2021 s-n-1-0. All rights reserved.
//

import SwiftUI

public struct MMHeatmapView: View {
    public init(start _start:Date,end _end:Date? = nil,data:[MMHeatmapData],style:MMHeatmapStyle = MMHeatmapStyle(baseCellColor: .label)){
        let cal = Calendar(identifier: .gregorian)
        let start = _start.truncate([.year,.month])
        let startYmd = start.getYmdhms()!
        let end = (_end != nil) ? _end!.truncateHms() : Date().truncateHms()
        let formatter = DateFormatter()
        formatter.dateFormat = style.dateMMFormat
        self.displayFormatter = formatter
        self.yyyy = startYmd.year
        self.MM = startYmd.month
        self.data = data.compactMap{
                item in
            if let elapsedDay = cal.dateComponents([.day],from:start,to:item.date).day{
                return MMHeatmapElapsedData(elapsedDay: elapsedDay, value: item.value)
            }else{
                return nil
            }
        }
        //x月1日基準で差を求める
        self.range = cal.dateComponents([.month], from: start.truncate([.year,.month]),to:end.truncate([.year,.month])).month! + 1
        self.maxElapsedDay = style.clippedWithEndDate ?  Calendar(identifier: .gregorian).dateComponents([.day],from:start,to:end).day: nil
        self.maxValue = data.max(by:{
            (a, b) -> Bool in
            a.value < b.value
        })?.value ?? 10
        self.style = style
    }
    @ObservedObject var style:MMHeatmapStyle
    let calendar = Calendar( identifier: .gregorian)
    let displayFormatter:DateFormatter
    let yyyy:Int
    let MM:Int
    let data:[MMHeatmapElapsedData]
    let range:Int
    let maxValue:Int
    let maxElapsedDay:Int?
    public var body: some View {
        HStack(alignment:.bottom){
            VStack{
                Text(style.week[0]).font(.footnote).foregroundColor(Color(UIColor.systemRed))
                Spacer()
                Text(style.week[3]).font(.footnote)
                Spacer()
                Text(style.week[6]).font(.footnote).foregroundColor(Color(UIColor.systemBlue))
            }.frame(height: 10*7 + 2*6)
            ForEach( MM ..< (MM + range)){
                i in
                VStack{
                    Text(GetMMTitle(MM: i)).font(.footnote)
                    MMHeatmapMMView(yyyy: yyyy, startMM: MM, MM: i,data:data, maxValue: maxValue,maxElapsedDay:maxElapsedDay)
                }
                if(i != (MM + range - 1)){
                    Divider().frame(height: 10*7 + 2*6).offset(x:0,y:-5) }
            }
        }.frame(alignment:.bottom).environmentObject(style)
    }
    func GetMMTitle(MM:Int)->String{
        var comp = DateComponents()
        comp.year = yyyy
        comp.day = 1
        comp.month = MM
        if let date = calendar.date(from: comp){
           return displayFormatter.string(from: date)
        }else{
            return "\(MM)"
        }
    }
}
struct MMHeatmap_Previews: PreviewProvider {
    static var previews: some View {
        MMHeatmapView(start: Calendar(identifier: .gregorian).date(from: DateComponents(year:2022,month: 2,day: 15))!, data: [MMHeatmapData(year: 2022, month: 4, day:1, value: 10)], style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo))
    }
}
