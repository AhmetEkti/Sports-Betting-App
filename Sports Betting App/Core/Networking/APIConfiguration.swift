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
        do {
            let apiKey = try ConfigurationManager.shared.string(forKey: "APIKey")
            self.apiKey = apiKey
            
            if KeychainManager.save(apiKey.data(using: .utf8)!, forKey: "APIKey") {
                print("API key loaded from Configuration and saved to Keychain")
            } else {
                print("Failed to save API key to Keychain")
            }
        } catch {
            print("Failed to load API key from Configuration: \(error)")
            
            if let data = KeychainManager.load(forKey: "APIKey"),
               let apiKey = String(data: data, encoding: .utf8) {
                self.apiKey = apiKey
                print("API key loaded from Keychain")
            } else {
                print("No valid API key found in Keychain")
            }
        }
        
        if apiKey == nil {
            print("WARNING: No API key set. App functionality may be limited.")
        }
    }
    
    func setAPIKey(_ newKey: String) {
        if KeychainManager.save(newKey.data(using: .utf8)!, forKey: "APIKey") {
            self.apiKey = newKey
            print("New API key set and saved to Keychain")
        } else {
            print("Failed to save new API key to Keychain")
        }
    }
}
