//
//  Market.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import Foundation

struct Market: Codable {
    let key: String
    let lastUpdate: String
    let outcomes: [Outcome]
    
    enum CodingKeys: String, CodingKey {
        case key
        case lastUpdate = "last_update"
        case outcomes
    }
}
