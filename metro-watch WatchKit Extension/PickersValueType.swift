//
//  PickersValueType.swift
//  metro-watch WatchKit Extension
//
//  Created by Максим Спиридонов on 03.06.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import WatchKit

enum PickersValueType {
    case timeSignature
    case timeSignatureHalf
    case subdivision
    case bars
    case minutes
    case seconds
    
    func getPickerItems() -> [WKPickerItem] {
        var result: [WKPickerItem] = []
        switch self {
        case .timeSignature:
            
            var items: [Int] = []
            for item in 1...59 {
                items.append(item)
            }
            result = items.map {
                let pickerItem = WKPickerItem()
                pickerItem.caption = "\($0)"
                pickerItem.title = "\($0)"
                return pickerItem
            }
        case .timeSignatureHalf:
            let items = [1, 2, 4, 8, 16, 32]
            result = items.map {
                let pickerItem = WKPickerItem()
                pickerItem.caption = "\($0)"
                pickerItem.title = "\($0)"
                return pickerItem
            }
        case .subdivision:
            let item = WKPickerItem()
            item.caption = "1"
            item.caption = "2"
            return [item]
        case .bars:
            var items: [Int] = []
            for item in 1...99 {
                items.append(item)
            }
            
            result = items.map {
                let pickerItem = WKPickerItem()
                pickerItem.caption = "\($0)"
                pickerItem.title = "\($0)"
                return pickerItem
            }
        case .minutes:
            var items: [Int] = []
            for item in 1...59 {
                items.append(item)
            }
            
            result = items.map {
                let pickerItem = WKPickerItem()
                pickerItem.caption = "\($0)"
                pickerItem.title = "\($0)"
                return pickerItem
            }
        case .seconds:
            var items: [Int] = []
            for item in 1...59 {
                items.append(item)
            }
            
            result = items.map {
                let pickerItem = WKPickerItem()
                pickerItem.caption = "\($0)"
                pickerItem.title = "\($0)"
                return pickerItem
            }
        }

        return result
    }
    
}
