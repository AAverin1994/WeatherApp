//
//  CurrentWeatherUnits.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import Foundation

struct CurrentWeatherUnits: TaoDecodable {
    let temperature: String
    let winddirection: String
    let windspeed: String
    
    init(_ object: [String : Any]) throws {
        self.temperature = try Self.parseValue(object, key: "temperature")
        self.winddirection = try Self.parseValue(object, key: "winddirection")
        self.windspeed = try Self.parseValue(object, key: "windspeed")
    }
}
