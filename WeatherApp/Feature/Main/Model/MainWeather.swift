//
//  MainWeather.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import Foundation

struct MainWeather: Identifiable {
    let id = UUID()
    let city: String
    let date: Date
    let isLowerTempreture: Bool
    let tempreture: String
    let windspeed: String
    let windDirection: String
    
    let geocoding: OpenMeteoGeocoding
}
