//
//  BettingEventCellViewModel.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/5/24.
//

import Foundation

class BettingEventCellViewModel {
    let event: BettingEvent
    private let dateFormatter: DateFormatter
    
    var shouldHighlight: Bool = false
    
    init(event: BettingEvent, previousEvent: BettingEvent?) {
        self.event = event
        self.dateFormatter = DateFormatter()
        self.dateFormatter.locale = Locale(identifier: "tr_TR")
        self.dateFormatter.timeZone = TimeZone(identifier: "Europe/Istanbul")
        
        self.shouldHighlight = Self.checkShouldHighlight(currentEvent: event, previousEvent: previousEvent)
    }
    
    private static func checkShouldHighlight(currentEvent: BettingEvent, previousEvent: BettingEvent?) -> Bool {
        guard let previousEvent = previousEvent else {
            return false
        }
        
        let currentDate = currentEvent.commenceTimeDate
        let previousDate = previousEvent.commenceTimeDate
        
        return currentDate?.isInSameDay(as: previousDate) == true &&
        currentEvent.sportKey == previousEvent.sportKey
    }
    
    var sportTitle: String {
        return event.sportTitle
    }
    
    var formattedDate: String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: event.commenceTime) else {
            return "Geçersiz tarih"
        }
        
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm"
            return "Bugün \(dateFormatter.string(from: date))"
        } else {
            dateFormatter.dateFormat = "d MMMM HH:mm"
            return dateFormatter.string(from: date)
        }
    }
    
    var eventTitle: String {
        return "\(event.homeTeam) - \(event.awayTeam)"
    }
    
    var odds: (homeOutcome: Outcome?, drawOutcome: Outcome?, awayOutcome: Outcome?) {
        guard let bookmaker = event.bookmakers.first,
              let market = bookmaker.markets.first(where: { $0.key == "h2h" }) else {
            return (nil, nil, nil)
        }
        
        var homeOutcome: Outcome?
        var awayOutcome: Outcome?
        var drawOutcome: Outcome?
        
        for outcome in market.outcomes {
            switch outcome.name {
            case event.homeTeam:
                homeOutcome = outcome
            case event.awayTeam:
                awayOutcome = outcome
            case "Draw":
                drawOutcome = outcome
            default:
                break
            }
        }
        
        return (homeOutcome, drawOutcome, awayOutcome)
    }
}

extension Date {
    func isInSameDay(as date: Date?) -> Bool {
        guard let otherDate = date else { return false }
        return Calendar.current.isDate(self, inSameDayAs: otherDate)
    }
}
