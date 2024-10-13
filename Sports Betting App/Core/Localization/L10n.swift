//
//  L10n.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/8/24.
//

import Foundation

enum L10n {
    enum General : String, LocalizationKey {
        case remove = "remove"
        case invalidDate = "invalid_date"
        case todayAtTime = "today_at_time"
        case formattedDate = "formatted_date"
    }
    
    enum BettingDashboard: String, LocalizationKey {
        case searchPlaceholderText = "search_placeholder_text"
        case noMatchesFound = "no_matches_found"
    }
    
    enum BettingBasket: String, LocalizationKey {
        case noBetsFound = "no_bets_found"
    }
    
    enum Tabbar: String, LocalizationKey {
        case bettingList = "tabbar_betting_list"
        case basketList = "tabbar_basket_list"
    }
    
    enum BetTypes: String, LocalizationKey {
        case eventTitle = "event_title"
        case sportTitle = "sport_title"
        case matchResult = "bet_type_match_result"
        case price = "bet_basket_price"
        case marketType = "market_type"
    }
}

extension L10n.Tabbar {
    static func basketList(_ match: Int, _ odds : Double) -> String {
        String(format: NSLocalizedString(L10n.Tabbar.basketList.localized, comment: ""), match,odds)
    }
}

extension L10n.General {
    static func formattedDate(date: Date?) -> String {
        guard let date = date else {
            return NSLocalizedString(L10n.General.invalidDate.localized, comment: "")
        }
        
        if date.isToday {
            let format = ConfigurationManager.shared.dateFormat(for: "Today")
            let time = date.toString(format: format)
            return String(format: NSLocalizedString(L10n.General.todayAtTime.localized, comment: ""), time)
        } else {
            let format = ConfigurationManager.shared.dateFormat(for: "Other")
            let formattedDate = date.toString(format: format)
            return String(format: NSLocalizedString(L10n.General.formattedDate.localized, comment: ""), formattedDate)
        }
    }
}

extension L10n.BettingDashboard {
    static func noMatchesFound(_ searchText: String) -> String {
        String(format: NSLocalizedString(L10n.BettingDashboard.noMatchesFound.localized, comment: ""), searchText)
    }
}

extension L10n.BetTypes {
    static func marketType(_ type: String) -> String {
        String(format: NSLocalizedString(L10n.BetTypes.marketType.localized, comment: ""), type)
    }
}

extension L10n.BetTypes {
    static func eventTitle(_ homeTeam: String, _ awayTeam: String) -> String {
        String(format: NSLocalizedString(L10n.BetTypes.eventTitle.localized, comment: ""), homeTeam, awayTeam)
    }
    
    static func sportTitle(_ title: String) -> String {
        String(format: NSLocalizedString(L10n.BetTypes.sportTitle.localized, comment: ""), title)
    }
    
    static func price(_ price: Double) -> String {
        return String(format: NSLocalizedString(L10n.BetTypes.price.localized, comment: ""), price)
    }
}
