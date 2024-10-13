//
//  BettingEventCellViewModel.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/5/24.
//

import Foundation

class BettingEventCellViewModel {
    let event: BettingEvent
    let shouldHighlight: Bool
    let odds: (homeOutcome: Outcome?, drawOutcome: Outcome?, awayOutcome: Outcome?)
    
    init(event: BettingEvent, previousEvent: BettingEvent?) {
        self.event = event
        self.shouldHighlight = Self.checkShouldHighlight(currentEvent: event, previousEvent: previousEvent)
        self.odds = Self.extractOdds(from: event)
    }
    
    private static func checkShouldHighlight(currentEvent: BettingEvent, previousEvent: BettingEvent?) -> Bool {
        guard let previousEvent = previousEvent else { return false }
        
        let currentDate = currentEvent.commenceTimeDate
        let previousDate = previousEvent.commenceTimeDate
        
        return currentDate?.isInSameDay(as: previousDate) == true &&
        currentEvent.sportKey == previousEvent.sportKey
    }
    
    private static func extractOdds(from event: BettingEvent) -> (Outcome?, Outcome?, Outcome?) {
        guard let bookmaker = event.bookmakers.first,
              let market = bookmaker.markets.first(where: { $0.key == ConfigurationManager.shared.marketType }) else {
            return (nil, nil, nil)
        }
        
        let homeOutcome = market.outcomes.first { $0.name == event.homeTeam }
        let awayOutcome = market.outcomes.first { $0.name == event.awayTeam }
        let drawOutcome = market.outcomes.first { $0.name == event.draw }
        
        return (homeOutcome, drawOutcome, awayOutcome)
    }
    
    var sportTitle: String {
        return L10n.BetTypes.sportTitle(event.sportTitle)
    }
    
    var formattedDate: String {
        guard let date = event.commenceTimeDate else {
            return L10n.General.invalidDate.localized
        }
        return L10n.General.formattedDate(date: date)
    }
    
    var eventTitle: String {
        return L10n.BetTypes.eventTitle(event.homeTeam, event.awayTeam)
    }
    
    func outcomeInfo(for type: BettingOutcome) -> (isAvailable: Bool, price: String, text: String) {
        let outcome: Outcome?
        switch type {
        case .homeWin:
            outcome = odds.homeOutcome
        case .draw:
            outcome = odds.drawOutcome
        case .awayWin:
            outcome = odds.awayOutcome
        }
        
        let isAvailable = outcome != nil
        let price = L10n.BetTypes.price(outcome?.price ?? 0)
        let text = L10n.BetTypes.marketType(type.code)
        
        return (isAvailable, price, text)
    }
}
