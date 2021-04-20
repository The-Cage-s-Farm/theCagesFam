//
//  UserDefaultsWrapper.swift
//  CagesFarm
//
//  Created by Tales Conrado on 09/04/21.
//

import Foundation

enum UserDefaultsKeys: String {
    case isSoundOn
    case isVibrationOn
}

@propertyWrapper
struct UserDefaultsWrapper<T> {
    let key: UserDefaultsKeys
    let defaultValueForKey: T

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValueForKey
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
}
