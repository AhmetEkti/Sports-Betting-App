//
//  BettingAnalyticsEvent.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/7/24.
//

import Foundation
import FirebaseAnalytics

enum BettingAnalyticsEvent: AnalyticsEvent {
    case betAdded(eventId: String, marketType: String, odds: Double)
    case betUpdated(eventId: String, marketType: String, odds: Double)
    case betRemoved(eventId: String, marketType: String)
    case basketUpdated(totalItems: Int, totalOdds: Double)
    case search(query: String)
    case basketViewed
    
    var name: String {
        switch self {
        case .betAdded: return "bet_added"
        case .betUpdated: return "bet_updated"
        case .betRemoved: return "bet_removed"
        case .basketUpdated: return "basket_updated"
        case .search: return "search_performed"
        case .basketViewed: return "basket_viewed"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .betAdded(let eventId, let marketType, let odds):
            return ["event_id": eventId, "market_type": marketType, "odds": odds]
        case .betUpdated(let eventId, let marketType, let odds):
            return ["event_id": eventId, "market_type": marketType, "odds": odds]
        case .betRemoved(let eventId, let marketType):
            return ["event_id": eventId, "market_type": marketType]
        case .basketUpdated(let totalItems, let totalOdds):
            return ["total_items": totalItems, "total_odds": totalOdds]
        case .search(let query):
            return ["search_query": query]
        case .basketViewed:
            return nil
        }
    }
}
