//
//  BasketItemCellViewModel.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/13/24.
//

import Foundation

class BasketItemCellViewModel {
    private let basketItem: BasketItem
    
    init(basketItem: BasketItem) {
        self.basketItem = basketItem
    }
    
    var eventTitle: String {
        return L10n.BetTypes.eventTitle(basketItem.event.homeTeam, basketItem.event.awayTeam)
    }
    
    var marketType: String {
        return L10n.BetTypes.marketType(basketItem.marketType)
    }
    
    var odds: String {
        return L10n.BetTypes.price(basketItem.selectedOutcome.price)
    }
    
    var date: String {
        if let date = basketItem.event.commenceTimeDate {
            return L10n.General.formattedDate(date: date)
        } else {
            return L10n.General.invalidDate.localized
        }
    }
    
    var matchResult: String {
        return L10n.BetTypes.matchResult.localized
    }
}
