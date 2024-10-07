//
//  AnalyticsEvent.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/7/24.
//

import Foundation
import FirebaseAnalytics

protocol AnalyticsEvent {
    var name: String { get }
    var parameters: [String: Any]? { get }
}
