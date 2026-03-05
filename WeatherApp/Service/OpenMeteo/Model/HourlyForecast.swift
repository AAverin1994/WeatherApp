//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import Foundation

struct HourlyWeather: TaoDecodable {
    let temperature: [Double]
    let visibility: [Double]
    let cloudCover: [Double]
    let pressure: [Double]
    let humidity: [Double]
    let time: [String]
    
    init(_ object: [String : Any]) throws {
        self.temperature = try Self.parseValue(object, key: "temperature_2m")
        self.visibility = try Self.parseValue(object, key: "visibility")
        self.cloudCover = try Self.parseValue(object, key: "cloud_cover")
        self.pressure = try Self.parseValue(object, key: "pressure_msl")
        self.humidity = try Self.parseValue(object, key: "relative_humidity_2m")
        self.time = try Self.parseValue(object, key: "time")
    }
}
