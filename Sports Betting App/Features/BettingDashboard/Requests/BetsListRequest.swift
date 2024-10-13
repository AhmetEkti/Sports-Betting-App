//
//  BetsListRequest.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/5/24.
//

import Foundation

struct BetsListRequest: APIRequestProtocol {
    let regions: String = ConfigurationManager.shared.marketArea
    let markets: String = ConfigurationManager.shared.marketType
    
    var method: HTTPMethod { .get }
    var path: String { "/v4/sports/upcoming/odds" }
    var parameters: [String: Any]? {
        var params: [String: Any] = [
            "regions": regions,
            "markets": markets
        ]
        
        if let apiKey = APIConfiguration.shared.apiKey {
            params["apiKey"] = apiKey
        }
        
        return params
    }
}
