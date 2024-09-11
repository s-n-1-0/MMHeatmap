//
//  [MMHeatmapData]Tests.swift
//  MMHeatmapDataArrayTests.swift
//
//  Created by Mac10 on 2024/09/09.
//

import XCTest
@testable import MMHeatmap

// [MMHeatmapData]
final class MMHeatmapDataArrayTests: XCTestCase {
    
    func testDateRange(){
        let calendar = Calendar.current
        
        let dataList = [
            MMHeatmapData(date: calendar.date(from: DateComponents(year:2024,month: 1,day: 1))!, value: 1000), // X
            MMHeatmapData(date: calendar.date(from: DateComponents(year:2024,month: 1,day: 2))!, value: 10), // O
            MMHeatmapData(date: calendar.date(from: DateComponents(year:2024,month: 3,day: 1))!, value: 5), // O
            MMHeatmapData(date: calendar.date(from: DateComponents(year:2024,month: 6,day: 1))!, value: 9999)  // X
        ].dateRange(start: calendar.date(from: DateComponents(year:2024,month: 1,day: 2))!,
                    end: calendar.date(from: DateComponents(year:2024,month: 3,day: 1))!)
        
        XCTAssertEqual(dataList.count, 2)
        XCTAssertEqual(dataList.max(by: { (l,r) -> Bool in
            l.value < r.value
        })?.value, 10)
    }
    
}
