# MMHeatmap
<img width="375" alt="HeatmapSample" src="https://user-images.githubusercontent.com/72431055/115141826-5572b580-a079-11eb-822b-4e05cf9273ca.png">

Heatmap style calendar made in SwiftUI.
## Installation
1. Use **"Swift Package Manager"**:  
`File -> Swift Packages -> Add Package Dependency`  
  
2. Paste URL:  
`https://github.com/s-n-1-0/MMHeatmap.git`


## MMHeatmapView
Displays a calendar from "start" to "end".
```swift
//"import  MMHeatmap" is required
let start = Calendar(identifier: .gregorian).date(from: DateComponents(year:2021,month: 12,day: 20))!
let end = Calendar(identifier: .gregorian).date(from: DateComponents(year:2022,month: 4,day: 3))! // or nil = now

MMHeatmapView(start: start,end:end, data: [MMHeatmapData(year: 2022, month: 4, day:1, value: 10)], style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo,isScroll: true))
```
*The variable "style:" is optional.  
<br>
## MMHeatmapViewData
Calendar cell data.  
Please not duplicate dates in MMHeatmapViewData.
#### **(year,month,day) or date**

```swift
public init(date _date:Date,value:Int)
```
```swift
public init(year:Int,month:Int,day:Int,value:Int)
```

#### **value:**
Specifies the color strength of the cell.  
Specify a value greater than or equal to 0.  
*If you want to set Color.clear, use "nil".

## MMHeatmapStyle
| Variable  |Description                                                                |     | 
| ------------- | ------------------------------------------------------------------------------ | --- | 
| baseCellColor | Maximum color                                                                  |     | 
| minCellColor  | Color when value is 0                                                          |     | 
| week          | Notation of the day of the week                                                |     | 
| dateMMFormat  | Months format<br>Example: 4<br>"M" = 4<br>"MM" = 04<br>"MMM" = en: Apr , ja: 4月 |     |
|clippedWithEndDate|**true** : If you want to display cells up to end parameter.<br>**false** : if you want to display cells until the end of the month in the last month.|
|isScroll|scrolling.<br>*Disabled for iOS13|

---

### Use in Widget Extension

Read this. https://github.com/s-n-1-0/MMHeatmap/issues/2

### PR / Issues
Please PR or Issues if you have any questions.
