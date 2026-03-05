//
//  TaoDecodable.swift
//  WeatherApp
//
//  Created by Andrey on 04.03.2026.
//

import Foundation

protocol TaoDecodable {
    init(_ object: [String: Any]) throws
}

extension TaoDecodable {
    static func parseValue<T>(
        _ object: [String: Any],
        key: String
    ) throws -> T {
        guard let value = object[key] as? T else {
            throw TaoDecodableError("Can not parse value for key \"\(key)\" in type: \(Self.self)")
        }
        
        return value
    }
    
    static func parseValue<T: TaoDecodable>(
        _ object: [String: Any],
        key: String
    ) throws -> [T] {
        guard let values = object[key] as? [[String: Any]] else {
            throw TaoDecodableError("Can not parse value for key \"\(key)\" in type: \(Self.self)")
        }
        
        return try values.map { try T($0) }
    }
    
    static func parseValue<T: TaoDecodable>(
        _ object: [String: Any],
        key: String
    ) throws -> T {
        guard let object = object[key] as? [String: Any] else {
            throw TaoDecodableError("Can not parse value for key \"\(key)\" in type: \(Self.self)")
        }
        
        return try T(object)
    }
}
