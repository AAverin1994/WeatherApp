//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import Foundation

struct DailyForecast: TaoDecodable {
    let time: [String]
    let maxTempretures: [Double]
    let minTempretures: [Double]
    
    init(_ object: [String : Any]) throws {
        self.time = try Self.parseValue(object, key: "time")
        self.maxTempretures = try Self.parseValue(object, key: "temperature_2m_max")
        self.minTempretures = try Self.parseValue(object, key: "temperature_2m_min")
    }
}
