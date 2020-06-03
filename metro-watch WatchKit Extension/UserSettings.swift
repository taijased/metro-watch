//
//  UserSettings.swift
//  metro-watch WatchKit Extension
//
//  Created by Максим Спиридонов on 03.06.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation


// MARK: - TimeDurationState
struct TimeDurationState: Codable {
    let type: Int
    let first: Int?
    let second: Int?
}


// MARK: - TimeSignatureState
struct TimeSignatureState: Codable {
    let left: Int?
    let right: Int?
}



final class UserSettings {
    
    fileprivate enum SettingsKey: String {
        case timeDuration
        case timeSignature
    }
    
    
    static var timeSignature: TimeSignatureState? {
        get {
            return getValue(type: TimeSignatureState.self, settingKey: .timeSignature)
        }
        set {
            setValue(newValue, settingKey: .timeSignature)
        }
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
    
    
    
    
    
    static fileprivate func setValue<T: Encodable>(_ newValue: T, settingKey: SettingsKey) {
        let defaults = UserDefaults.standard
        let key = settingKey.rawValue
        if let jsonData = try? JSONEncoder().encode(newValue) {
            defaults.set(String(decoding: jsonData, as: UTF8.self), forKey: key)
        }
    }
    
    
    static fileprivate func getValue<T: Decodable>(type: T.Type, settingKey: SettingsKey) -> T? {
        guard
            let jsonString = UserDefaults.standard.string(forKey: settingKey.rawValue),
            let data = jsonString.data(using: .utf8)
            else { return nil }
        return decodeJSON(type: T.self, from: data)
    }
    
    static fileprivate func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
            
        } catch let jsonError {
//            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
