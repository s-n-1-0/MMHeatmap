//
//  MMHeatmapMMView.swift
//  Diarrrrrrrrrry
//
//  Created by Mac10 on 2021/04/13.
//  Copyright © 2021 s-n-1-0. All rights reserved.
//

import SwiftUI

struct MMHeatmapMMView: View {
    init(yyyy:Int,startMM:Int,MM:Int,data:[MMHeatmapElapsedData],maxValue:Int,maxElapsedDay:Int?) {
        //指定した月の最終日を取得
        let calendar = Calendar(identifier: .gregorian)
        var comp = DateComponents()
        comp.year = yyyy
        comp.month = startMM
        comp.day = 1
        startDate = calendar.date(from: comp)!
        //----
        comp.month = MM + 1
        comp.day = 0
        // 0 = 前の月の最終日
         // 求めたい月の最後の日のDateオブジェクトを得る
         let date = calendar.date(from: comp)!
         lastDay = calendar.component(.day, from: date)
        maxWeeks = calendar.component(.weekOfMonth, from: date)
        self.yyyy = yyyy
        self.MM = MM
        self.data = data
        self.calendar = calendar
        self.maxValue = maxValue
        self.maxElapsedDay = maxElapsedDay
    }
    let calendar:Calendar
    let yyyy:Int
    let MM:Int
    let data:[MMHeatmapElapsedData]
    let startDate:Date
    let lastDay:Int
    let maxWeeks:Int
    let maxValue:Int
    let maxElapsedDay:Int?
    var body: some View {
        HStack(spacing:2){
            //表示月
            ForEach(0..<maxWeeks){ w in
              let values = getWeekOfMonthDataValues(weekOfMonth: w + 1)
                //1基準
            let Idx = investigateWeekIndex(w: w)
                MMHeatmapColumnView(startIdx: Idx.startIdx, endIdx: Idx.endIdx, values: values, maxValue: maxValue)
            }
        }
    }
    func makeDateComponents(dd:Int?) -> DateComponents{
        var comp = DateComponents()
        comp.year = yyyy
        comp.month = MM
        comp.day = dd
        return comp
    }
    func investigateWeekIndex(w:Int)->(startIdx:Int,endIdx:Int){
        if(w == 0){
            let start = getWeekday(dd: 1)
         return (start,6)
        }else if (w == (maxWeeks - 1)){
            let end = getWeekday(dd: lastDay)
            return (0,end)
        }else{
            return (0,6)
        }
    }
    //0-6
    func getWeekday(dd:Int)->Int{
        let date = calendar.date(from: makeDateComponents(dd: dd))!
        return calendar.component(.weekday, from: date) - 1
    }
    //絶対に7つ返る 日月火水木金土
    func getWeekOfMonthDataValues(weekOfMonth:Int)->[Int?]{
        var values:[Int?] = []
        var seComp = DateComponents()
        seComp.year = yyyy
        seComp.month = MM
        seComp.weekOfMonth = weekOfMonth
        for weekday in 1...7 {
            //曜日1-7
            seComp.weekday = weekday
            if let date = calendar.date(from: seComp) {
                let elapsed = calendar.dateComponents([.day], from:startDate,to:date).day!
                if maxElapsedDay == nil || maxElapsedDay! >= elapsed{
                if let value =  data.first(where: {$0.elapsedDay == elapsed})?.value{
                    values.append(value)
                }else{
                    values.append(0)
                }
                }else{
                    values.append(nil)
                }
            }
        }
      return values
    }
}

struct MMHeatmapMMView_Previews: PreviewProvider {
    static var previews: some View {
        MMHeatmapMMView(yyyy: 2021, startMM: 2, MM: 2,data:[
        MMHeatmapElapsedData(elapsedDay: 0, value: 5),
        MMHeatmapElapsedData(elapsedDay: 1, value: 7)
        ], maxValue: 10,maxElapsedDay: 20).environmentObject(MMHeatmapStyle(baseCellColor: UIColor.black)).environmentObject(MMHeatmapLayout())
    }
}
