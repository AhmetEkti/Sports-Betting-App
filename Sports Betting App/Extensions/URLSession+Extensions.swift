//
//  URLSession+Extensions.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import Foundation
import Combine

extension URLSession {
    func dataTaskPublisher<T: Decodable>(for request: URLRequest) -> AnyPublisher<T, Error> {
        return self.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
