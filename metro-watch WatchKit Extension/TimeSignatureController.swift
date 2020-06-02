//
//  TimeSignatureController.swift
//  metro-watch WatchKit Extension
//
//  Created by Максим Спиридонов on 02.06.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import WatchKit
import Foundation


final class TimeSignatureController: WKInterfaceController {
    
    
    @IBOutlet weak var leftPicker: WKInterfacePicker!
    @IBOutlet weak var rightPicker: WKInterfacePicker!
    
    
    @IBOutlet weak var leftBorderImage: WKInterfaceImage!
    @IBOutlet weak var rightBorderImage: WKInterfaceImage!
    
    
    @IBAction func leftPickerChanged(_ value: Int) {
        WKInterfaceDevice.current().play(.click)
        DispatchQueue.main.async { [weak self] in
            self?.rightBorderImage.setImage(UIImage(named: "green_border_small"))
            self?.leftBorderImage.setImage(UIImage(named: "white_border_small"))
        }
    }

    
    @IBAction func rightPickerChanged(_ value: Int) {
        WKInterfaceDevice.current().play(.click)
        DispatchQueue.main.async { [weak self] in
            self?.leftBorderImage.setImage(UIImage(named: "green_border_small"))
            self?.rightBorderImage.setImage(UIImage(named: "white_border_small"))
        }
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupPickers()
    }
    
    
    fileprivate func setupPickers() {
        
        print(#function)
        
        
        
        
        //Сделай леха тут такие какие нужны данные
        let leftItemList: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        let pickerItems: [WKPickerItem] = leftItemList.map {
            let pickerItem = WKPickerItem()
            pickerItem.caption = "\($0)"
            pickerItem.title = "\($0)"
            return pickerItem
        }
        
        
        leftPicker.setItems(pickerItems)
        rightPicker.setItems(pickerItems)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func doneTapped() {
        print(#function)
    }
    
}
