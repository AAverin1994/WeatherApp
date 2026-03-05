//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import Foundation

struct CurrentWeather: TaoDecodable {
    let isDay: Bool
    let weatherCode: WeatherCode
    let time: String
    let temperature: Double
    let winddirection: Int
    let windspeed: Double
    
    init(_ object: [String : Any]) throws {
        let isDay: Int = try Self.parseValue(object, key: "is_day")
        self.isDay = isDay == 1
        
        self.weatherCode = .test //try Self.parseValue(object, key: "weathercode")
        self.time = try Self.parseValue(object, key: "time")
        self.temperature = try Self.parseValue(object, key: "temperature")
        self.winddirection = try Self.parseValue(object, key: "winddirection")
        self.windspeed = try Self.parseValue(object, key: "windspeed")
    }
}
