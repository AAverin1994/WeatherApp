//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import Foundation

struct WeatherDayDetails: Identifiable {
    let id = UUID()
    let date: Date
    let tempreture: String
    let pressure: String
    let humidity: String
    let visibility: String
    let cloudCover: String
}

struct WeatherDetails {
    let city: String
    let details: [WeatherDayDetails]
}
