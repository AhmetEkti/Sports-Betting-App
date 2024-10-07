//
//  Bookmaker.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import Foundation

struct Bookmaker: Codable, Identifiable {
    let key: String
    let title: String
    let lastUpdate: String
    let markets: [Market]
    
    var id: String { key }
    
    enum CodingKeys: String, CodingKey {
        case key, title
        case lastUpdate = "last_update"
        case markets
    }
}
