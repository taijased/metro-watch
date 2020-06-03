//
//  SongDurationController.swift
//  metro-watch WatchKit Extension
//
//  Created by Максим Спиридонов on 02.06.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import WatchKit
import Foundation

class SongDurationController: WKInterfaceController {
    
    
    
    var songDurationValue: TimeDurationState
    
    
    //Type Picker
    
    @IBOutlet weak var typePicker: WKInterfacePicker!
    @IBOutlet weak var typePickerImage: WKInterfaceImage!
    
    
    
    @IBAction func typePickerChanged(_ value: Int) {
        WKInterfaceDevice.current().play(.click)
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
            self.songDurationValue = TimeDurationState(type: 0, first: nil, second: nil)
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
            

            
            let first = (self.songDurationValue.first != nil) ? self.songDurationValue.first : 0
            self.songDurationValue = TimeDurationState(type: 1, first: first, second: nil)
        case 2:
            
            centerPicker.setItems(PickersValueType.minutes.getPickerItems())
            lastPicker.setItems(PickersValueType.seconds.getPickerItems())
            
            DispatchQueue.main.async {
                self.typePickerImage.setImage(UIImage(named: "white_border_small"))
                self.centerPickerImage.setImage(UIImage(named: "white_border_small"))
            }
            let second = (self.songDurationValue.second != nil) ? self.songDurationValue.second : 0
            let first = (self.songDurationValue.first != nil) ? self.songDurationValue.first : 0
            self.songDurationValue = TimeDurationState(type: 2, first: first, second: second)
        default:
            break
        }
        DispatchQueue.main.async {
            self.typePickerImage.setImage(UIImage(named: "green_border_small"))
        }
    }
    
    
    // Center Picker
    
    @IBOutlet weak var centerPickerImage: WKInterfaceImage!
    @IBOutlet weak var centerPicker: WKInterfacePicker!
    
    
    @IBAction func centerPickerChanged(_ value: Int) {
        WKInterfaceDevice.current().play(.click)
        DispatchQueue.main.async {
            self.centerPickerImage.setImage(UIImage(named: "green_border_small"))
            self.typePickerImage.setImage(UIImage(named: "white_border_small"))
            self.lastPickerImage.setImage(UIImage(named: "white_border_small"))
        }
        self.songDurationValue = TimeDurationState(type: 1, first: value, second: self.songDurationValue.second)
    }
    
    //Last Picker
    
    
    @IBOutlet weak var lastPickerImage: WKInterfaceImage!
    @IBOutlet weak var lastPicker: WKInterfacePicker!
    @IBAction func lastPickerChanged(_ value: Int) {
        WKInterfaceDevice.current().play(.click)
        DispatchQueue.main.async {
            self.centerPickerImage.setImage(UIImage(named: "white_border_small"))
            self.typePickerImage.setImage(UIImage(named: "white_border_small"))
            self.lastPickerImage.setImage(UIImage(named: "green_border_small"))
        }
        
        
        self.songDurationValue = TimeDurationState(type: 1, first: self.songDurationValue.first, second: value)

    }
    
    
    
    
    override init() {
        songDurationValue = UserSettings.timeDuration
        super.init()
        
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
        
        typePicker.setSelectedItemIndex(songDurationValue.type)
        typePicker.setItems([offItem, barsItem, timeItem])
        
        switch songDurationValue.type {
        case 0:
            centerPicker.setItems([offItem])
            lastPicker.setItems([offItem])
        case 1:
            typePicker.setSelectedItemIndex(songDurationValue.type)
            
            centerPicker.setItems(PickersValueType.bars.getPickerItems())
            centerPicker.setSelectedItemIndex(songDurationValue.first ?? 0)
            lastPicker.setItems([offItem])
        case 2:
            typePicker.setSelectedItemIndex(songDurationValue.type)
            
            centerPicker.setItems(PickersValueType.minutes.getPickerItems())
            centerPicker.setSelectedItemIndex(songDurationValue.first ?? 0)
            lastPicker.setItems(PickersValueType.seconds.getPickerItems())
            centerPicker.setSelectedItemIndex(songDurationValue.second ?? 0)
        default:break
        }
          
        
       
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
        UserSettings.timeDuration = self.songDurationValue
        print("====")
        print(self.songDurationValue)
        print(UserSettings.timeDuration)
        self.dismiss()
    }
    
}

