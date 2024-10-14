//
//  APIRequestProtocol.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol APIRequestProtocol {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
}

extension APIRequestProtocol {
    func asURLRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let parameters = parameters {
            if method == .get {
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
