//
//  Outcome.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import Foundation

struct Outcome: Codable, Identifiable {
    let name: String
    let price: Double
    
    var id: String { name }
}
