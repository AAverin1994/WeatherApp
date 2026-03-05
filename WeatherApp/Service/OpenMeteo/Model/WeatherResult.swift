//
//  WeatherResult.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import Foundation

struct WeatherResult: Identifiable {
    let id = UUID()
    let geocoding: OpenMeteoGeocoding
    let forecast: Forecast
}
