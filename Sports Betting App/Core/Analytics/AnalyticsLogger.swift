//
//  AnalyticsLogger.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/7/24.
//

import Foundation
import FirebaseAnalytics

class AnalyticsLogger {
    static let shared = AnalyticsLogger()
    
    private let manager: AnalyticsManager
    
    private init(manager: AnalyticsManager = FirebaseAnalyticsManager.shared) {
        self.manager = manager
    }
    
    func logEvent(_ event: AnalyticsEvent) {
        manager.logEvent(event)
    }
    
    func logBetAdded(eventId: String, marketType: String, odds: Double) {
        logEvent(BettingAnalyticsEvent.betAdded(eventId: eventId, marketType: marketType, odds: odds))
    }
    
    func logBetUpdated(eventId: String, marketType: String, odds: Double) {
        logEvent(BettingAnalyticsEvent.betUpdated(eventId: eventId, marketType: marketType, odds: odds))
    }
    
    func logBetRemoved(eventId: String, marketType: String) {
        logEvent(BettingAnalyticsEvent.betRemoved(eventId: eventId, marketType: marketType))
    }
    
    func logBasketUpdated(totalItems: Int, totalOdds: Double) {
        logEvent(BettingAnalyticsEvent.basketUpdated(totalItems: totalItems, totalOdds: totalOdds))
    }
    
    func logSearch(query: String) {
        logEvent(BettingAnalyticsEvent.search(query: query))
    }
    
    func logBasketViewed() {
        logEvent(BettingAnalyticsEvent.basketViewed)
    }
}
