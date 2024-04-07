//
//  MMHeatmapLayoutTests.swift
//
//
//  Created by s-n-1-0 on 2024/03/30.
//

import XCTest
@testable import MMHeatmap
final class MMHeatmapLayoutTests: XCTestCase {
    
    func testMMHeatmapMonthViewWidth(){
        let layout = MMHeatmapLayout()
        let width = layout.calcMMHeatmapMonthViewWidth(year: 2021, month: 2)
        XCTAssertEqual(width,58) // <- (weeks * cellsize) + (weeks-1) * cellspacing
    }
    
    func testMMHeatmapMonthViewHeight(){
        let cellSize = 20.240963855421687
        let layout = MMHeatmapLayout(cellSize: cellSize)
        XCTAssertEqual(layout.backwardCellSize(viewHeight: 200), cellSize)
        
        XCTAssertEqual(layout.mmHeatmapViewHeight,200)
    }
    
    func testMMHeatmapViewContentWidth(){
        // short case
        let layout = MMHeatmapLayout()
        let calender = Calendar(identifier: .gregorian)
        var start = calender.date(from: DateComponents(year:2022,month: 3,day: 20))!
        var end = calender.date(from: DateComponents(year:2022,month: 4,day: 3))!
        XCTAssertEqual(layout.calcMMHeatmapViewContentWidth(start: start, end: end),136)
        
        // long case
        start = calender.date(from: DateComponents(year:2021,month: 10,day: 20))!
        end = calender.date(from: DateComponents(year:2022,month: 4,day: 3))!
        XCTAssertEqual(layout.calcMMHeatmapViewContentWidth(start: start, end: end),550)
    }
}
