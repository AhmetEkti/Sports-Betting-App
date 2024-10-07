//
//  FirebaseAnalyticsManager.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/7/24.
//

import Foundation
import FirebaseAnalytics

class FirebaseAnalyticsManager: AnalyticsManager {
    static let shared = FirebaseAnalyticsManager()
    
    private init() {}
    
    func logEvent(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }
}
