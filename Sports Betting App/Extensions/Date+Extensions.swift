//
//  Date+Extensions.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/8/24.
//

import Foundation

extension Date {
    func isInSameDay(as date: Date?) -> Bool {
        guard let otherDate = date else { return false }
        return Calendar.current.isDate(self, inSameDayAs: otherDate)
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
}

extension DateFormatter {
    static let shared: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    static func date(from string: String, format: String) -> Date? {
        shared.dateFormat = format
        return shared.date(from: string)
    }
}

extension String {
    var iso8601Date: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self)
    }
}
