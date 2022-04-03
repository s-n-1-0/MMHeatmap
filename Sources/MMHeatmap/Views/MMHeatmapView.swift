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
        VStack(alignment:.leading){
        HStack(alignment:.bottom){
            VStack{
                Text(style.week[0]).font(.footnote).foregroundColor(Color(UIColor.systemRed))
                Spacer()
                Text(style.week[3]).font(.footnote)
                Spacer()
                Text(style.week[6]).font(.footnote).foregroundColor(Color(UIColor.systemBlue))
            }.frame(height: 10*7 + 2*6)
            HStack(alignment:.bottom){
                ForEach( MM ..< (MM + range)){
                    i in
                    VStack{
                        Text(GetMMTitle(MM: i)).font(.footnote)
                        MMHeatmapMMView(yyyy: yyyy, startMM: MM, MM: i,data:data, maxValue: maxValue,maxElapsedDay:maxElapsedDay)
                    }.frame(alignment:.bottom).id("MMHeatmapView:\(i)")
                    if(i != (MM + range - 1)){
                        Divider().frame(height: 10*7 + 2*6).offset(x:0,y:15)
                    }
                }
            }.modifier(Scroll14(isScroll:style.isScroll,idx:MM + range - 1))
        }
        }.frame(alignment:.leading).environmentObject(style)
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
 fileprivate struct Scroll14:ViewModifier{
    let isScroll:Bool
    let idx:Int
   @ViewBuilder func body(content: Content) -> some View {
        if #available(iOS 14.0, *){
            if isScroll{
                ScrollView(.horizontal){
                    ScrollViewReader{
                        proxy in
                        content.onAppear{
                            proxy.scrollTo("MMHeatmapView:\(idx)", anchor: .trailing)
                        }
                    }
                }
            }else{
                content.modifier(NotScroll())
            }
        }else{
             content.modifier(NotScroll())
        }
    }
}
fileprivate struct NotScroll:ViewModifier{
    @State private var totalHeight = CGFloat(100)
    func body(content: Content) -> some View {
        GeometryReader{ //ここの高さは実行時に修正されます。
            gp in
            ZStack{
                HStack{
                content
                Spacer() // for frameWidth > contentWidth
                }.frame(maxWidth:gp.size.width,alignment: .trailing).clipped()
            }.background(GeometryReader{
                gp2->Color in
                DispatchQueue.main.async {
                    self.totalHeight = gp2.size.height
                }
                return Color.clear
            })
        }.frame(height:totalHeight)
    }
}
struct MMHeatmap_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
        //scroll
            MMHeatmapView(start: Calendar(identifier: .gregorian).date(from: DateComponents(year:2021,month: 12,day: 20))!,end:Calendar(identifier: .gregorian).date(from: DateComponents(year:2022,month: 4,day: 3))!, data: [MMHeatmapData(year: 2022, month: 4, day:1, value: 10)], style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo,isScroll: true))
        //not scroll
            MMHeatmapView(start: Calendar(identifier: .gregorian).date(from: DateComponents(year:2021,month: 12,day: 20))!,end:Calendar(identifier: .gregorian).date(from: DateComponents(year:2022,month: 4,day: 3))!, data: [MMHeatmapData(year: 2022, month: 4, day:1, value: 10)], style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo,isScroll: false))
        //scroll (for frameWidth < contentWidth)
            MMHeatmapView(start: Calendar(identifier: .gregorian).date(from: DateComponents(year:2022,month: 3,day: 20))!,end:Calendar(identifier: .gregorian).date(from: DateComponents(year:2022,month: 4,day: 3))!, data: [MMHeatmapData(year: 2022, month: 4, day:1, value: 10)], style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo,isScroll: true))
        //not scroll (for frameWidth < contentWidth)
            MMHeatmapView(start: Calendar(identifier: .gregorian).date(from: DateComponents(year:2022,month: 3,day: 20))!,end:Calendar(identifier: .gregorian).date(from: DateComponents(year:2022,month: 4,day: 3))!, data: [MMHeatmapData(year: 2022, month: 4, day:1, value: 10)], style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo,isScroll: false))
        }
    }
}
