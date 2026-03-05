//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Andrey on 04.03.2026.
//

import Foundation

enum WeatherCode: TaoDecodable {
    case test
    
    init(_ object: [String : Any]) throws {
        self = .test
    }
}

struct Forecast: TaoDecodable {
    let timezone: String
    let currentWeather: CurrentWeather?
    let hourly: HourlyWeather?
    let hourlyUnits: HourlyUnits?
    let currentWeatherUnits: CurrentWeatherUnits?
    
    init(_ object: [String : Any]) throws {
        self.timezone = try Self.parseValue(object, key: "timezone")
        
        do {
            let currentWeather: CurrentWeather = try Self.parseValue(object, key: "current_weather")
            self.currentWeather = currentWeather
        } catch {
            self.currentWeather = nil
        }
        
        do {
            let currentWeather: HourlyWeather = try Self.parseValue(object, key: "hourly")
            self.hourly = currentWeather
        } catch {
            self.hourly = nil
        }
        
        do {
            let currentWeatherUnits: CurrentWeatherUnits = try Self.parseValue(object, key: "current_weather_units")
            self.currentWeatherUnits = currentWeatherUnits
        } catch {
            self.currentWeatherUnits = nil
        }
        
        do {
            let hourlyUnits: HourlyUnits = try Self.parseValue(object, key: "hourly_units")
            self.hourlyUnits = hourlyUnits
        } catch {
            self.hourlyUnits = nil
        }
    }
}
