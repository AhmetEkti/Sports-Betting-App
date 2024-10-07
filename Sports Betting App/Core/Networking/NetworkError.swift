//
//  NetworkError.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/3/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
    case serverError(statusCode: Int)
    case unknown

    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed:
            return "Network request failed"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}
