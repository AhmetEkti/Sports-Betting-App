//
//  BettingBasketViewModel.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/6/24.
//

import Foundation
import Combine
import FirebaseAnalytics

class BettingBasketViewModel {
    static let shared = BettingBasketViewModel()
    
    var basket: Basket = Basket()
    
    private init() {}
    
    func addToBasket(event: BettingEvent, outcome: Outcome, marketType: String) {
        if let index = basket.items.firstIndex(where: { $0.event.id == event.id }) {
            let existingItem = basket.items[index]
            
            if existingItem.marketType == marketType {
                let removedItem = BasketItem(event: event, selectedOutcome: outcome, marketType: marketType)
                basket.removeItem(at: index)

                AnalyticsLogger.shared.logBetRemoved(eventId: removedItem.event.id, marketType: removedItem.marketType)
            } else {
                let newItem = BasketItem(event: event, selectedOutcome: outcome, marketType: marketType)
                basket.items[index] = newItem
                
                AnalyticsLogger.shared.logBetUpdated(eventId: event.id, marketType: marketType, odds: outcome.price)
            }
        } else {
            let newItem = BasketItem(event: event, selectedOutcome: outcome, marketType: marketType)
            basket.addItem(newItem)
            
            AnalyticsLogger.shared.logBetAdded(eventId: event.id, marketType: marketType, odds: outcome.price)
        }
        
        AnalyticsLogger.shared.logBasketUpdated(totalItems: basket.items.count, totalOdds: basket.totalOdds)
    }
    
    func removeFromBasket(at index: Int) {
        guard index >= 0 && index < basket.items.count else {
            return
        }
        basket.removeItem(at: index)
    }
    
    func isOutcomeSelected(event: BettingEvent, marketType: String) -> Bool {
        return basket.items.contains { item in
            return item.event.id == event.id && item.marketType == marketType
        }
    }
}
