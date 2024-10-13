//
//  LocalizationKey.swift.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/8/24.
//

import Foundation

protocol LocalizationKey {
    var rawValue: String { get }
    var localized: String { get }
}

extension LocalizationKey {
    var localized: String {
        NSLocalizedString(rawValue, bundle: .main, comment: "")
    }
}
