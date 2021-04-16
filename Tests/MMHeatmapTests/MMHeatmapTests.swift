import XCTest
 import MMHeatmap
final class MMHeatmapTests: XCTestCase {
    func testHeatmapStyleWeekCount() {
        XCTAssertEqual(MMHeatmapStyle(baseCellColor: UIColor.black).week.count,7)
    }
    func testHeatmapStyleAttributeAccess(){
        XCTAssertEqual(MMHeatmapStyle(baseCellColor: UIColor.black).minCellColor,UIColor.secondarySystemBackground)
        XCTAssertEqual(MMHeatmapStyle(baseCellColor: UIColor.black).baseCellColor, UIColor.black)
    }
}
