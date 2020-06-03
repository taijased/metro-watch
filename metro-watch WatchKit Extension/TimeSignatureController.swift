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
    
    
    var timeSignature: TimeSignatureState
    
    
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
        self.timeSignature = TimeSignatureState(left: value, right: self.timeSignature.right ?? 0)
    }

    
    @IBAction func rightPickerChanged(_ value: Int) {
        WKInterfaceDevice.current().play(.click)
        DispatchQueue.main.async { [weak self] in
            self?.leftBorderImage.setImage(UIImage(named: "green_border_small"))
            self?.rightBorderImage.setImage(UIImage(named: "white_border_small"))
        }
        self.timeSignature = TimeSignatureState(left: self.timeSignature.left ?? 0, right: value)
    }
    
    
    override init() {
        timeSignature = UserSettings.timeSignature ?? TimeSignatureState(left: 0, right: 0)
        super.init()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupPickers()
    }
    
    
    fileprivate func setupPickers() {
        
        leftPicker.setItems(PickersValueType.timeSignature.getPickerItems())
        rightPicker.setItems(PickersValueType.timeSignatureHalf.getPickerItems())
        
        leftPicker.setSelectedItemIndex(timeSignature.left ?? 0)
        rightPicker.setSelectedItemIndex(timeSignature.right ?? 0)
    }
    
    @IBAction func doneTapped() {
        UserSettings.timeSignature = self.timeSignature
        self.dismiss()
    }
    
}
