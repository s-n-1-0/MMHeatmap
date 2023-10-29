//
//  MMHeatmapLayout.swift
//  
//
//  Created by s-n-1-0 on 2023/10/29.
//

import SwiftUI
class MMHeatmapLayout:ObservableObject{
    let cellSize:CGFloat = 10
    let cellSpacing:CGFloat = 2
    let mmLabelHeight:CGFloat = 20
    let mmLabelVSpacing:CGFloat = 8
    var columnHeight:CGFloat{
        get{
            cellSize * 7 + cellSpacing * 6
        }
    }
    var mmHeatmapViewHeight:CGFloat{
        get{
            columnHeight + mmLabelHeight + mmLabelVSpacing
        }
    }
}
