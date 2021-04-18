# MMHeatmap
<img width="375" alt="HeatmapSample" src="https://user-images.githubusercontent.com/72431055/115141826-5572b580-a079-11eb-822b-4e05cf9273ca.png">

Heatmap style calendar made in SwiftUI.
## Installation
1. Use **"Swift Package Manager"**:  
`File -> Swift Packages -> Add Package Dependency`  
  
2. Paste URL:  
`https://github.com/s-n-1-0/MMHeatmap.git`


## MMHeatmapView

```swift
//"import  MMHeatmap" is required
MMHeatmapView(yyyy: 2021,MM:4, data: [MMHeatmapData(elapsedDay: 15, value: 10)], range: 3,style: MMHeatmapStyle(baseCellColor: UIColor.systemIndigo))
```
*It will be displayed for three months starting from April, i.e. until June.  
*The variable "style:" is optional.  
<br>
## MMHeatmapViewData
#### ・**elapsedDay:**  
Specify the number of days elapsed based on MM.  
<br>
*Example: MM = 4*   
* `elapsedDay:0 = April 1`  
* `elapsedDay:30 = May 1`  
Note that it starts with 0.  
<br>

"elapsedDay" can be obtained in the following way.
```swift
//startDate:Date = 4/1/2021
elapsedDay = Calendar(identifier: .gregorian).dateComponents([.day],from:startDate,to:date).day
```

#### ・**value:**
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
<br>
If you want to add a style, please suggest it in "GitHub Issues".