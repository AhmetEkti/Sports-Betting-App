//
//  BasketItem.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/6/24.
//

import Foundation

struct BasketItem: Identifiable {
    let id = UUID()
    let event: BettingEvent
    let selectedOutcome: Outcome
    let marketType: String 
}
