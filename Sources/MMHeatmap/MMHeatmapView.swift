//
//  MMHeatmapView.swift
//  Diarrrrrrrrrry
//
//  Created by Mac10 on 2021/04/13.
//  Copyright © 2021 s-n-1-0. All rights reserved.
//

import SwiftUI

public struct MMHeatmapView: View {
   public init(yyyy:Int,MM:Int,data:[MMHeatmapData],range:Int,style:MMHeatmapStyle = MMHeatmapStyle(baseCellColor: UIColor.label)) {
        let formatter = DateFormatter()
        formatter.dateFormat = style.dateMMFormat
        self.displayFormatter = formatter
        self.yyyy = yyyy
        self.MM = MM
        self.data = data
        self.range = range
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
    let data:[MMHeatmapData]
    let range:Int
    let maxValue:Int
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
                MMHeatmapMMView(yyyy: yyyy, startMM: MM, MM: i,data:data, maxValue: maxValue)
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
        MMHeatmapView(yyyy: 2021,MM:4, data: [MMHeatmapData(elapsedDay: 15, value: 10)], range: 3,style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo))
    }
}
