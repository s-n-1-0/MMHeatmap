//
//  [MMHeatmapData].swift
//  
//
//  Created by Mac10 on 2024/09/09.
//

import Foundation

extension [MMHeatmapData]{
    
    func dateRange(start:Date, end:Date) -> [MMHeatmapData]{
        self.compactMap{
            item in
            (start <= item.date && end >= item.date) ? item : nil
        }
    }
}
