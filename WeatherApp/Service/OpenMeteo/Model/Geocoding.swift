//
//  Geocoding.swift
//  WeatherApp
//
//  Created by Andrey on 04.03.2026.
//

import Foundation

struct OpenMeteoGeocoding: TaoDecodable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(_ object: [String : Any]) throws {
        self.id = try Self.parseValue(object, key: "id")
        self.name = try Self.parseValue(object, key: "name")
        self.latitude = try Self.parseValue(object, key: "latitude")
        self.longitude = try Self.parseValue(object, key: "longitude")
    }
}

struct GeocodingResult: TaoDecodable {
    let result: [OpenMeteoGeocoding]
    
    init(_ object: [String : Any]) throws {
        self.result =  try Self.parseValue(object, key: "results")
    }
}
