//
//  MMHeatmapWeekView.swift
//
//  Created by Mac10 on 2021/04/13.
//  Copyright © 2021 s-n-1-0. All rights reserved.
//

import SwiftUI
struct MMHeatmapWeekView:View {
    init(startIdx:Int,endIdx:Int,values:[Int?],maxValue:Int) {
        start = startIdx
        end = endIdx
        self.values = values
        self.maxValue = maxValue
    }
    @EnvironmentObject var style:MMHeatmapStyle
    @EnvironmentObject var layout:MMHeatmapLayout
    let start:Int
    let end:Int
    let values:[Int?]
    let maxValue:Int
    var body: some View{
        VStack(spacing:layout.cellSpacing){
            ForEach(0..<7){ i in
                RoundedRectangle(cornerRadius: layout.cellSize * 0.2).frame(width: layout.cellSize,height: layout.cellSize).modifier(CellColorModifier(isRange: (i >= start && i <= end ) , value: values[i], maxValue: maxValue,minColor: style.minCellColor,baseColor: style.baseCellColor))
            }
        }
    }
}
fileprivate struct CellColorModifier:ViewModifier {
    init(isRange:Bool,value:Int?,maxValue:Int,minColor:UIColor,baseColor:UIColor) {
        self.isRange = isRange
        if let v = value{
            let pct:CGFloat = CGFloat(v) / CGFloat(maxValue)
            var secondHue:CGFloat = 0
            var secondSaturation:CGFloat = 0
            var secondBrightness:CGFloat = 0
            var secondAlpa:CGFloat = 0
            minColor.getHue(&secondHue, saturation: &secondSaturation, brightness: &secondBrightness, alpha: &secondAlpa)
            var hue:CGFloat = 0
            var saturation:CGFloat = 0
            var brightness:CGFloat = 0
            var alpha:CGFloat = 0
            baseColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            saturation = (saturation - secondSaturation) * pct + secondSaturation
            brightness = (brightness - secondBrightness) * pct + secondBrightness
            self.rangeColor = Color(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
        }else{
            self.rangeColor = Color(UIColor.clear)
        }
    }
    let isRange:Bool
    let rangeColor:Color
    func body(content: Content) -> some View {
        Group{
            if(isRange){
                content.foregroundColor(rangeColor)
            }else{
                content.foregroundColor(Color.clear)
            }
        }
    }
}

#Preview{
    MMHeatmapWeekView(startIdx: 0, endIdx: 6,values: [Int](repeating: 0, count: 7), maxValue: 10).environmentObject(MMHeatmapStyle(baseCellColor: UIColor.black))//0-6
        .environmentObject(MMHeatmapLayout())
}
