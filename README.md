# MMHeatmap

## In Preparation
Wait a minute.

---

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
*The variable "style" is optional.  
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
Calendar(identifier: .gregorian).dateComponents([.day],from:startDate,to:date).day
```

#### ・**value:**
Specifies the color strength of the cell.  
Specify a value greater than or equal to 0.  
*If you want to set Color.clear, use "nil".

## MMHeatmapStyle
Wait a minute.