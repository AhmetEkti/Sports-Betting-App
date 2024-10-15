//
//  Environment.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/3/24.
//

import Foundation

enum Environment {
    case development
    case staging
    case production
    
    var baseURL: URL {
        switch self {
        case .development:
            return URL(string: "https://api.the-odds-api.com")!
        case .staging:
            return URL(string: "https://stage-api.the-odds-api.com")!
        case .production:
            return URL(string: "https://gateway-api.the-odds-api.com")!
        }
    }
    
    static var current: Environment {
        #if DEBUG_FLAG
        return .development
        #elseif STAGING_FLAG
        return .staging
        #elseif PRODUCTION_FLAG
        return .production
        #else
        fatalError("No environment flag set")
        #endif
    }
}
