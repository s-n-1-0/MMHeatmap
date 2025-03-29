//
//  Calendar+Tests.swift
//
//  Created by s-n-1-0 on 2024/09/09.
//

import XCTest
@testable import MMHeatmap

final class CalendarTests: XCTestCase {
    
    func testLastDateOfMonth() {
        let calendar = Calendar.current
        
        // 2024/3 -> 2024/3/31
        let lastDateMarch = calendar.lastDateOfMonth(year: 2024, month: 3)
        let expectedMarch = Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 31))
        XCTAssertEqual(lastDateMarch, expectedMarch)
        
        // 2024/2 (leap year) -> 2024/2/29
        let lastDateFebLeap = calendar.lastDateOfMonth(year: 2024, month: 2)
        let expectedFebLeap = Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 29))
        XCTAssertEqual(lastDateFebLeap, expectedFebLeap)
        
        // 2023/2 (not leap year) -> 2023/2/28
        let lastDateFebCommon = calendar.lastDateOfMonth(year: 2023, month: 2)
        let expectedFebCommon = Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 28))
        XCTAssertEqual(lastDateFebCommon, expectedFebCommon)
        
        // 2024/12 -> 2024/12/31
        let lastDateDec = calendar.lastDateOfMonth(year: 2024, month: 12)
        let expectedDec = Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 31))
        XCTAssertEqual(lastDateDec, expectedDec)
        
        // #3
        let lastDate = calendar.lastDateOfMonth(year: 2025, month: 3)
        let expected = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 31))
        XCTAssertEqual(lastDate, expected)
    }
}
