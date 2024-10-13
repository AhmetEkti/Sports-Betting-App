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

enum BettingOutcome: String {
    case homeWin = "HomeWin"
    case draw = "Draw"
    case awayWin = "AwayWin"
    
    var code: String {
        ConfigurationManager.shared.bettingOutcomeCode(for: self) ?? "Unkown"
    }
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
    
    func bettingOutcomeCode(for outcome: BettingOutcome) -> String? {
        guard let outcomes = configuration["BettingOutcomes"] as? [String: String] else {
            return nil
        }
        return outcomes[outcome.rawValue]
    }
    
    func dateFormat(for key: String) -> String {
        guard let formats = configuration["Formats"] as? [String: Any],
              let dateFormats = formats["Date"] as? [String: String],
              let format = dateFormats[key] else {
            return "d MMMM HH:mm"
        }
        return format
    }
    
    var marketType: String {
        return configuration["MarketType"] as? String ?? "h2h"
    }
    
    var marketArea: String {
        return configuration["MarketArea"] as? String ?? "eu"
    }
}
