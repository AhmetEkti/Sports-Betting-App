//
//  URLEncodedFormEncoder.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/4/24.
//

import Foundation

struct URLEncodedFormEncoder {
    static func encode<T: Encodable>(_ value: T) throws -> [URLQueryItem] {
        let data = try JSONEncoder().encode(value)
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return dictionary(from: json).map { URLQueryItem(name: $0, value: "\($1)") }
    }
    
    private static func dictionary(from jsonObject: Any) -> [String: Any] {
        guard let dict = jsonObject as? [String: Any] else { return [:] }
        return dict.reduce(into: [String: Any]()) { result, element in
            if let array = element.value as? [Any] {
                result[element.key] = array.map { dictionary(from: $0) }
            } else if let dict = element.value as? [String: Any] {
                result[element.key] = dictionary(from: dict)
            } else {
                result[element.key] = element.value
            }
        }
    }
}
