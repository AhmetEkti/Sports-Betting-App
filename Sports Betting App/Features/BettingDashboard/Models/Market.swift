//
//  Market.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import Foundation

struct Market: Codable, Identifiable {
    let key: String
    let lastUpdate: String
    let outcomes: [Outcome]
    
    var id: String { key }
    
    enum CodingKeys: String, CodingKey {
        case key
        case lastUpdate = "last_update"
        case outcomes
    }
}
