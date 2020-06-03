//
//  SettingsController.swift
//  metro-watch WatchKit Extension
//
//  Created by Максим Спиридонов on 02.06.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import WatchKit
import Foundation

class SettingsController: WKInterfaceController {

    
    
    @IBOutlet weak var playButton: WKInterfaceButton!
    
    @IBAction func playButtonTapped() {
         print(#function)
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
       
    }
    
    @IBOutlet weak var timeSignatureLabel: WKInterfaceButton!
    
    override func willActivate() {
        super.willActivate()
        let items = [1, 2, 4, 8, 16, 32]
        let state = UserSettings.timeSignature
        let label = "\((state?.left ?? 0) + 1)/\(items[state?.right ?? 0])"
        
        //хуевый хак че то гоолова не работает что нибудь лучше придумать
        
        self.timeSignatureLabel.setTitle(label)
    }
    
}
