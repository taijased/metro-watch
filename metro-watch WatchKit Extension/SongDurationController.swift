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


class SongDurationController: WKInterfaceController {
    
    
    //value
    
    
    var songDurationValue: (type: Int?, Int?, Int?) = (type: 0, nil, nil)
    
    
    //Type Picker
    
    @IBOutlet weak var typePicker: WKInterfacePicker!
    @IBOutlet weak var typePickerImage: WKInterfaceImage!
    
    
    
    @IBAction func typePickerChanged(_ value: Int) {
        
        switch value {
        case 0:
            
            let offItem = WKPickerItem()
            offItem.caption = "off"
            offItem.title = "-"
            centerPicker.setItems([offItem])
            lastPicker.setItems([offItem])
            DispatchQueue.main.async {
                self.centerPickerImage.setImage(UIImage(named: "white_border_small"))
                self.lastPickerImage.setImage(UIImage(named: "white_border_small"))
            }
        case 1:
            
            let offItem = WKPickerItem()
            offItem.caption = "off"
            offItem.title = "-"
            centerPicker.setItems(PickersValueType.bars.getPickerItems())
            lastPicker.setItems([offItem])
            DispatchQueue.main.async {
                self.typePickerImage.setImage(UIImage(named: "white_border_small"))
                self.lastPickerImage.setImage(UIImage(named: "white_border_small"))
            }
        case 2:
            
            centerPicker.setItems(PickersValueType.minutes.getPickerItems())
            lastPicker.setItems(PickersValueType.seconds.getPickerItems())
            
            DispatchQueue.main.async {
                self.typePickerImage.setImage(UIImage(named: "white_border_small"))
                self.centerPickerImage.setImage(UIImage(named: "white_border_small"))
            }
        default:
            break
        }
        DispatchQueue.main.async {
            self.typePickerImage.setImage(UIImage(named: "green_border_small"))
        }
        
        self.songDurationValue = (type: 0, nil, nil)
    }
    
    
    // Center Picker
    
    @IBOutlet weak var centerPickerImage: WKInterfaceImage!
    @IBOutlet weak var centerPicker: WKInterfacePicker!
    
    
    @IBAction func centerPickerChanged(_ value: Int) {
        DispatchQueue.main.async {
            self.centerPickerImage.setImage(UIImage(named: "green_border_small"))
            self.typePickerImage.setImage(UIImage(named: "white_border_small"))
            self.lastPickerImage.setImage(UIImage(named: "white_border_small"))
        }
        self.songDurationValue = (type: 1, value, self.songDurationValue.2)
    }
    
    
    //Last Picker
    
    
    @IBOutlet weak var lastPickerImage: WKInterfaceImage!
    @IBOutlet weak var lastPicker: WKInterfacePicker!
    @IBAction func lastPickerChanged(_ value: Int) {
        DispatchQueue.main.async {
            self.centerPickerImage.setImage(UIImage(named: "white_border_small"))
            self.typePickerImage.setImage(UIImage(named: "white_border_small"))
            self.lastPickerImage.setImage(UIImage(named: "green_border_small"))
        }
        self.songDurationValue = (type: 2, self.songDurationValue.1, value)
    }
    
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        initPickers()
    }
    
    
    
    fileprivate func initPickers() {
        
        let offItem = WKPickerItem()
        offItem.caption = "off"
        offItem.title = "-"
        
        let barsItem = WKPickerItem()
        barsItem.caption = "bars"
        barsItem.title = "B"
        
        let timeItem = WKPickerItem()
        timeItem.caption = "timeItem"
        timeItem.title = "T"
        
        
        
        typePicker.setItems([offItem, barsItem, timeItem])
        centerPicker.setItems([offItem])
        lastPicker.setItems([offItem])
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func doneTappeed() {
        print(self.songDurationValue)
        
    }
    
}

