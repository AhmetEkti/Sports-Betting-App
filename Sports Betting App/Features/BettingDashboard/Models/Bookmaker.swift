//
//  Bookmaker.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import Foundation

struct Bookmaker: Codable {
    let title: String
    let lastUpdate: String
    let markets: [Market]
    
    enum CodingKeys: String, CodingKey {
        case title
        case lastUpdate = "last_update"
        case markets
    }
}
