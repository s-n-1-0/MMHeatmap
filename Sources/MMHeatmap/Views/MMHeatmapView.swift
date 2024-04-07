//
//  MMHeatmapView.swift
//  Diarrrrrrrrrry
//
//  Created by Mac10 on 2021/04/13.
//  Copyright © 2021 s-n-1-0. All rights reserved.
//

import SwiftUI

public struct MMHeatmapView: View {
    public init(start _start:Date,
                end _end:Date? = nil,
                data:[MMHeatmapData],
                style:MMHeatmapStyle = MMHeatmapStyle(baseCellColor: .label),
                layout:MMHeatmapLayout = MMHeatmapLayout()
    ){
        let cal = Calendar(identifier: .gregorian)
        let start = _start.truncate([.year,.month])
        let startYmd = start.getYmdhms()!
        let end = (_end != nil) ? _end!.truncateHms() : Date().truncateHms()
        let formatter = DateFormatter()
        formatter.dateFormat = style.dateMMFormat
        self.displayFormatter = formatter
        self.start = start
        self.end = end
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
        self.range = cal.monthRange(start: start, end: end)
        self.maxElapsedDay = style.clippedWithEndDate ?  Calendar(identifier: .gregorian).dateComponents([.day],from:start,to:end).day: nil
        self.maxValue = data.max(by:{
            (a, b) -> Bool in
            a.value < b.value
        })?.value ?? 10
        self.style = style
        self._layout = ObservedObject(initialValue: layout)
    }
    @ObservedObject var style:MMHeatmapStyle
    @ObservedObject var layout:MMHeatmapLayout
    let calendar = Calendar( identifier: .gregorian)
    let displayFormatter:DateFormatter
    let start:Date
    let end:Date
    let yyyy:Int
    let MM:Int
    let data:[MMHeatmapElapsedData]
    let range:Int
    let maxValue:Int
    let maxElapsedDay:Int?
    public var body: some View {
        HStack(alignment:.bottom){
            VStack{
                Text(style.week[0])
                    .font(.system(size: layout.mmLabelHeight))
                    .foregroundColor(Color(UIColor.systemRed))
                Spacer()
                Text(style.week[3]).font(.system(size: layout.mmLabelHeight))
                Spacer()
                Text(style.week[6])
                    .font(.system(size: layout.mmLabelHeight))
                    .foregroundColor(Color(UIColor.systemBlue))
            }.frame(height: layout.columnHeight).layoutPriority(1)
            HStack(alignment:.bottom,spacing: 0){
                ForEach( MM ..< (MM + range),id:\.self){
                    i in
                    VStack(spacing:0){
                        Text(getMMLabel(MM: i)).font(.system(size: layout.mmLabelHeight)) // actual pixel size: -4 //why???
                            .fixedSize(horizontal: true, vertical: false).padding([.top,.bottom],layout.mmLabelVSpacing)
                        MMHeatmapMonthView(yyyy: yyyy, startMM: MM, MM: i,data:data, maxValue: maxValue,maxElapsedDay:maxElapsedDay)
                    }.frame(alignment:.bottom).id("MMHeatmapView:\(i)")
                    if(i != (MM + range - 1)){
                        Divider().frame(width:layout.dividerWidth,height: layout.cellSize*7 + layout.cellSpacing*6).offset(x:0,y:15)
                    }
                }
            }.modifier(Scroll14(isScroll:style.isScroll, innerContentWidth: layout.calcMMHeatmapViewContentWidth(start: start, end: end),idx:MM + range - 1))
        }.frame(alignment:.leading).environmentObject(style).environmentObject(layout)
    }
    
    func getMMLabel(MM:Int)->String{
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
fileprivate struct Scroll14:ViewModifier{
    let isScroll:Bool
    let innerContentWidth:CGFloat
    let idx:Int
    @EnvironmentObject var layout:MMHeatmapLayout
    @ViewBuilder func body(content: Content) -> some View {
        Group{
            if #available(iOS 14.0, *),isScroll{
                ScrollView(.horizontal){
                    ScrollViewReader{
                        proxy in
                        content.onAppear{
                            proxy.scrollTo("MMHeatmapView:\(idx)", anchor: .trailing)
                        }
                    }
                }
            }else{
                content.modifier(DisabledScroll(innerContentWidth: innerContentWidth))
            }
        }.frame(maxWidth:innerContentWidth)
    }
}
fileprivate struct DisabledScroll:ViewModifier{
    let innerContentWidth:CGFloat
    @EnvironmentObject var layout:MMHeatmapLayout
    func body(content: Content) -> some View {
        GeometryReader{
            gp in
            content.frame(width:gp.size.width < innerContentWidth ? gp.size.width : innerContentWidth,height:layout.mmHeatmapViewHeight,alignment: .trailing).clipped()
        }.frame(height:layout.mmHeatmapViewHeight)
    }
}

#Preview{
    let calendar = Calendar(identifier: .gregorian)
    return VStack{
        //scroll
        MMHeatmapView(start: calendar.date(from: DateComponents(year:2021,month: 4,day: 20))!,
                      end:calendar.date(from: DateComponents(year:2022,month: 4,day: 3))!,
                      data: [MMHeatmapData(year: 2022, month: 4, day:1, value: 10)],
                      style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo,isScroll: true)).background(Color.green)
        //disable scroll
        MMHeatmapView(start: calendar.date(from: DateComponents(year:2021,month: 4,day: 20))!,
                      end:calendar.date(from: DateComponents(year:2022,month: 4,day: 3))!,
                      data: [MMHeatmapData(year: 2022, month: 4, day:1, value: 10)],
                      style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo,isScroll: false)).background(Color.green)
        //scroll (for frameWidth < contentWidth)
        HStack{
            MMHeatmapView(start: calendar.date(from: DateComponents(year:2022,month: 3,day: 20))!,
                          end:Calendar(identifier: .gregorian).date(from: DateComponents(year:2022,month: 4,day: 3))!,
                          data: [MMHeatmapData(year: 2022, month: 4, day:1, value: 10)],
                          style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo,
                          isScroll: true),
                          layout: MMHeatmapLayout(cellSize: 20)
            ).background(Color.green)
            Spacer()
        }
        //disable scroll (for frameWidth < contentWidth)
        HStack{
            MMHeatmapView(start: calendar.date(from: DateComponents(year:2022,month: 3,day: 20))!,
                          end:calendar.date(from: DateComponents(year:2022,month: 4,day: 3))!,
                          data: [MMHeatmapData(year: 2022, month: 4, day:1, value: 10)],
                          style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo,isScroll: false),
                          layout: MMHeatmapLayout(cellSize: 20)
            ).background(Color.green)
            Spacer()
        }
    }
}
