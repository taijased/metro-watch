//
//  InterfaceController.swift
//  metro-watch WatchKit Extension
//
//  Created by Максим Спиридонов on 02.06.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import WatchKit
import Foundation


class HomeController: WKInterfaceController {

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func tapToBPM(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func goToSettings(_ sender: Any) {
        print(#function)
        
        self.pushController(withName: "nextSegue", context: nil)
    }
    
}
