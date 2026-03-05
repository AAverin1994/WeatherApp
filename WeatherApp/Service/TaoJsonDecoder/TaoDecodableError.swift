//
//  TaoDecodableError.swift
//  WeatherApp
//
//  Created by Andrey on 04.03.2026.
//

import Foundation

struct TaoDecodableError: LocalizedError {
    let failureReason: String?
    
    init(_ failureReason: String) {
        self.failureReason = failureReason
    }
}
