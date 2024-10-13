//
//  DynamicLocalizationKey.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/8/24.
//

struct DynamicLocalizationKey: LocalizationKey {
    let rawValue: String
    
    init(_ key: String) {
        self.rawValue = key
    }
}

func dynamicLocalizationKey(_ key: String) -> LocalizationKey {
    return DynamicLocalizationKey(key)
}
