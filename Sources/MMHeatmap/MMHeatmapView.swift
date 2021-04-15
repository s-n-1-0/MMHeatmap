//
//  MMHeatmapView.swift
//  Diarrrrrrrrrry
//
//  Created by Mac10 on 2021/04/13.
//  Copyright © 2021 s-n-1-0. All rights reserved.
//

import SwiftUI

public struct MMHeatmapView: View {
    init(yyyy:Int,MM:Int,data:[MMHeatmapData],range:Int,style:MMHeatmapStyle = MMHeatmapStyle(baseCellColor: UIColor.systemOrange)) {
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
            }
            ForEach((MM - range + 1) ..< MM + 1){
                i in
                VStack{
                    Text("\(i)").font(.footnote)
                MMHeatmapMMView(yyyy: yyyy, startMM: MM - range + 1, MM: i,data:data, maxValue: maxValue)
                }
                if(i != MM){ Divider() }
            }
        }.frame(height: 10*7 + 2*6,alignment:.bottom).environmentObject(style)
    }
}
struct MMHeatmap_Previews: PreviewProvider {
    static var previews: some View {
        MMHeatmapView(yyyy: 2021,MM:4, data: [MMHeatmapData(elapsedDay: 73, value: 10)], range: 3)
    }
}
