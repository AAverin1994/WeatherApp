//
//  TaoDecoder.swift
//  WeatherApp
//
//  Created by Andrey on 04.03.2026.
//

import Foundation

enum TaoDecoderError: Error {
    case canNotParseData
}

final class TaoDecoder {
    private let decoder = TaoJsonDecoder()
    
    func decode<T: TaoDecodable>(_ type: T.Type, from: Data) throws -> T {
        let decodedResult = decoder.decode(from)
        
        if let error = decodedResult as? NSError {
            throw error
        }
        
        if let object = decodedResult as? [String: Any] {
            return try T(object)
        } else {
            throw TaoDecoderError.canNotParseData
        }
    }
}
