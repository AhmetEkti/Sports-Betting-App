//
//  APIConfiguration.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/3/24.
//

import Foundation

class APIConfiguration {
    static let shared = APIConfiguration()
    
    let environment: Environment
    private(set) var apiKey: String?
    
    private init() {
        self.environment = .current
        loadAPIKey()
    }
    
    private func loadAPIKey() {
        if let data = KeychainManager.load(forKey: "APIKey"),
           let apiKey = String(data: data, encoding: .utf8) {
            self.apiKey = apiKey
            print("API key loaded from Keychain")
        } else {
            do {
                let apiKey = try ConfigurationManager.shared.string(forKey: "APIKey")
                self.apiKey = apiKey
                if KeychainManager.save(apiKey.data(using: .utf8)!, forKey: "APIKey") {
                    print("API key loaded from Configuration and saved to Keychain")
                }
            } catch {
                print("Failed to load API key from Configuration")
            }
        }
    }
}
