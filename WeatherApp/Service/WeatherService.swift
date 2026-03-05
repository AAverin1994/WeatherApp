//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Andrey on 03.03.2026.
//

import Foundation

protocol WeatherService {
    func getWeathers(countries: [Country]) async throws -> [WeatherResult]
    func getWeather(geocoding: OpenMeteoGeocoding) async throws -> WeatherResult
    func getWeekWeather(geocoding: OpenMeteoGeocoding) async throws -> WeatherResult
}
