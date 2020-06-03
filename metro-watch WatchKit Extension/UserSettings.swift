//
//  UserSettings.swift
//  metro-watch WatchKit Extension
//
//  Created by Максим Спиридонов on 03.06.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation


// MARK: - Recording
struct TimeDurationState: Codable {
    let type: Int
    let first: Int?
    let second: Int?
}



final class UserSettings {
    
    fileprivate enum SettingsKey: String {
        case timeDuration
    }
    
    static var timeDuration: TimeDurationState {
        get {
            guard
                let jsonString = UserDefaults.standard.string(forKey: SettingsKey.timeDuration.rawValue),
                let data = jsonString.data(using: .utf8)
            else { return TimeDurationState(type: 0, first: nil, second: nil) }
            
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(TimeDurationState.self, from: data)
                return object
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                return TimeDurationState(type: 0, first: nil, second: nil)
            }
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKey.timeDuration.rawValue
            if let jsonData = try? JSONEncoder().encode(newValue) {
                defaults.set(String(decoding: jsonData, as: UTF8.self), forKey: key)
            }
            
        }
    }
}
