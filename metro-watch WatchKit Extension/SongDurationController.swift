//
//  SongDurationController.swift
//  metro-watch WatchKit Extension
//
//  Created by Максим Спиридонов on 02.06.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import WatchKit
import Foundation



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
            let items = [1...60]
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
            let items = [1...100]
            result = items.map {
                let pickerItem = WKPickerItem()
                pickerItem.caption = "\($0)"
                pickerItem.title = "\($0)"
                return pickerItem
            }
        case .minutes:
            let items = [1...59]
            result = items.map {
                let pickerItem = WKPickerItem()
                pickerItem.caption = "\($0)"
                pickerItem.title = "m"
                return pickerItem
            }
        case .seconds:
            let items = [1...59]
            result = items.map {
                let pickerItem = WKPickerItem()
                pickerItem.caption = "\($0)"
                pickerItem.title = "s"
                return pickerItem
            }
        }

        return result
    }
    
}



class SongDurationController: WKInterfaceController {

    
    //Type Picker
    
    @IBOutlet weak var typePicker: WKInterfacePicker!
    @IBOutlet weak var typePickerImage: WKInterfaceImage!
    @IBAction func typePickerChanged(_ value: Int) {
        
    }
    
    
    // Center Picker
    
    @IBOutlet weak var centerPickerImage: WKInterfaceImage!
    @IBOutlet weak var centerPicker: WKInterfacePicker!
    
    
    @IBAction func centerPickerChanged(_ value: Int) {
        
    }
    
    
    //Last Picker
    
    
    @IBOutlet weak var lastPickerImage: WKInterfaceImage!
    @IBOutlet weak var lastPicker: WKInterfacePicker!
    @IBAction func lastPickerChanged(_ value: Int) {
    }
    
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        initPickers()
    }
    
    
    
    fileprivate func initPickers() {
        
        
        let offItem = WKPickerItem()
        offItem.caption = "off"
        offItem.title = "Off"
        
        
        typePicker.setItems([offItem, offItem, offItem])
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
}
