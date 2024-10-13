//
//  BettingEvent.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import Foundation

struct BettingEvent: Codable, Identifiable {
    let id: String
    let sportKey: String
    let sportTitle: String
    let commenceTime: String
    let homeTeam: String
    let awayTeam: String
    let draw: String = "Draw"
    let bookmakers: [Bookmaker]
    
    enum CodingKeys: String, CodingKey {
        case id
        case sportKey = "sport_key"
        case sportTitle = "sport_title"
        case commenceTime = "commence_time"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case draw = "draw"
        case bookmakers
    }
}

extension BettingEvent {
    var commenceTimeDate: Date? {
        return commenceTime.iso8601Date
    }
}
