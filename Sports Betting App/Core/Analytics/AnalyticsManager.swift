//
//  AnalyticsManager.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/7/24.
//

import Foundation
import FirebaseAnalytics

protocol AnalyticsManager {
    func logEvent(_ event: AnalyticsEvent)
}


