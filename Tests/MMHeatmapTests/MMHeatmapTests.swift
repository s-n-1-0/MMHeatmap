import XCTest
@testable import MMHeatmap
final class MMHeatmapTests: XCTestCase {
    func testHeatmapStyleWeekCount() {
        XCTAssertEqual(MMHeatmapStyle(baseCellColor: UIColor.black).week.count,7)
    }
}
