//
//  Basket.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/6/24.
//

import Foundation

class Basket: ObservableObject {
    @Published var items: [BasketItem] = []
    @Published var stake: Double = 30.0
    @Published var systemBet: Int = 20
    @Published var multipleTickets: Int = 1
    
    var totalMatches: Int {
        items.count
    }
    
    var totalOdds: Double {
        items.reduce(1.0) { $0 * $1.selectedOutcome.price }
    }

    func addItem(_ item: BasketItem) {
        items.append(item)
    }
    
    func removeItem(at index: Int) {
        items.remove(at: index)
    }
}

