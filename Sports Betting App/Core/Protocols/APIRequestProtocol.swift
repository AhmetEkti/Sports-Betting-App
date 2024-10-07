//
//  APIRequestProtocol.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import Foundation

protocol APIRequestProtocol {
    var method: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }

    func asURLRequest(baseURL: URL) throws -> URLRequest
}

extension APIRequestProtocol {
    func asURLRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method

        if let parameters = parameters {
            if method == "GET" {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                request.url = components?.url
            } else {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            }
        }

        return request
    }
}
