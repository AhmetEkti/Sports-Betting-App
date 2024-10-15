//
//  NetworkManager.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/3/24.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ request: APIRequestProtocol) -> AnyPublisher<T, NetworkError>
}

class NetworkManager: NetworkManagerProtocol {
    private let configuration: APIConfiguration
    
    init(configuration: APIConfiguration = .shared) {
        self.configuration = configuration
    }
    
    func request<T: Decodable>(_ request: APIRequestProtocol) -> AnyPublisher<T, NetworkError> {
        guard let urlRequest = try? request.asURLRequest(baseURL: configuration.environment.baseURL) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { _ in NetworkError.requestFailed }
            .flatMap { data, response -> AnyPublisher<T, NetworkError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    return Just(data)
                        .decode(type: T.self, decoder: JSONDecoder())
                        .mapError { _ in NetworkError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.serverError(statusCode: httpResponse.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
