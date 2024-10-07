//
//  ConfigurationManager.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/3/24.
//

import Foundation

enum ConfigurationError: Error {
    case missingKey, invalidValue
}

class ConfigurationManager {
    static let shared = ConfigurationManager()
    
    private let configuration: [String: Any]
    
    private init() {
        guard let url = Bundle.main.url(forResource: "Configuration", withExtension: "plist"),
              let config = NSDictionary(contentsOf: url) as? [String: Any] else {
            fatalError("Configuration file not found or invalid")
        }
        self.configuration = config
    }
    
    func string(forKey key: String) throws -> String {
        guard let value = configuration[key] as? String else {
            throw ConfigurationError.missingKey
        }
        return value
    }
}
