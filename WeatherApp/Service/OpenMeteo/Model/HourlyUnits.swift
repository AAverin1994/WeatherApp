//
//  HourlyUnits.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import Foundation

struct HourlyUnits: TaoDecodable {
    let tempretureUnits: String
    let visibilityUnits: String
    let cloudCoverUnits: String
    let pressureUnits: String
    let humidityUnits: String
    
    init(_ object: [String : Any]) throws {
        self.tempretureUnits = try Self.parseValue(object, key: "temperature_2m")
        self.visibilityUnits = try Self.parseValue(object, key: "visibility")
        self.cloudCoverUnits = try Self.parseValue(object, key: "cloud_cover")
        self.pressureUnits = try Self.parseValue(object, key: "pressure_msl")
        self.humidityUnits = try Self.parseValue(object, key: "relative_humidity_2m")
    }
}
