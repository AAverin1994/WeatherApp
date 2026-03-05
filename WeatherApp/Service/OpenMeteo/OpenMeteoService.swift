//
//  OpenMeteoService.swift
//  WeatherApp
//
//  Created by Andrey on 04.03.2026.
//

import Foundation

enum OpenMeteoServiceError: Error {
    case canNotPrepareUrl
    case canNotParseData
    case noResult
    case unvalidRequest
}

final class OpenMeteoService {
    private let geocodingDomain = "geocoding-api.open-meteo.com"
    private let openMeteoDomain = "api.open-meteo.com"
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient = ApiClient()) {
        self.apiClient = apiClient
    }
}

// MARK: - WeatherService

extension OpenMeteoService: WeatherService {
    func getWeathers(countries: [Country]) async throws -> [WeatherResult] {
        try await withThrowingTaskGroup(of: WeatherResult.self) { group in
            for country in countries {
                group.addTask {
                    let geocodingModel = try await self.getGeocoding(for: country)
                    let forecast = try await self.getForecast(for: geocodingModel)
                    return WeatherResult(
                        geocoding: geocodingModel,
                        forecast: forecast
                    )
                }
            }
            
            var weathers = [WeatherResult]()
            for try await weather in group {
                weathers.append(weather)
            }
            return weathers
        }
    }
    
    func getWeather(geocoding: OpenMeteoGeocoding) async throws -> WeatherResult {
        let forecast = try await self.getForecast(for: geocoding)
        return WeatherResult(
            geocoding: geocoding,
            forecast: forecast
        )
    }
    
    func getWeekWeather(geocoding: OpenMeteoGeocoding) async throws -> WeatherResult {
        let forecast = try await self.getWeekForecast(for: geocoding)
        return WeatherResult(
            geocoding: geocoding,
            forecast: forecast
        )
    }
}

// MARK: - Private

private extension OpenMeteoService {
    private func getForecast(for model: OpenMeteoGeocoding) async throws -> Forecast {
        try await apiClient.execute(
            request: prepareForecastRequest(
                latitude: model.latitude,
                longitude: model.longitude
            )
        )
    }
    
    private func getWeekForecast(for model: OpenMeteoGeocoding) async throws -> Forecast {
        try await apiClient.execute(
            request: prepareWeekForecastRequest(
                latitude: model.latitude,
                longitude: model.longitude
            )
        )
    }

    private func getGeocoding(for country: Country) async throws -> OpenMeteoGeocoding {
        do {
            let response: GeocodingResult = try await apiClient.execute(
                request:  prepareGeocodingRequest(country: country)
            )
            
            guard let firstValue = response.result.first else {
                throw OpenMeteoServiceError.noResult
            }
            return firstValue
        } catch {
            throw error
        }
    }

    private func prepareGeocodingRequest(country: Country) throws -> URLRequest {
        var components = URLComponents(string: "https://\(geocodingDomain)/v1/search")

        components?.queryItems = [
            URLQueryItem(name: "name", value: country.rawValue),
            URLQueryItem(name: "count", value: "1"),
        ]
        
        guard let url = components?.url else {
            throw OpenMeteoServiceError.canNotPrepareUrl
        }
        
        return URLRequest(url: url)
    }

    private func prepareForecastRequest(
        latitude: Double,
        longitude: Double
    ) throws -> URLRequest {
        var components = URLComponents(string: "https://\(openMeteoDomain)/v1/forecast")

        components?.queryItems = [
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(name: "current_weather", value: "true")
        ]
        
        guard let url = components?.url else {
            throw OpenMeteoServiceError.canNotPrepareUrl
        }
        
        return URLRequest(url: url)
    }
    
    private func prepareWeekForecastRequest(
        latitude: Double,
        longitude: Double
    ) throws -> URLRequest {
        var components = URLComponents(string: "https://\(openMeteoDomain)/v1/forecast")

        components?.queryItems = [
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(name: "hourly", value: "temperature_2m,relative_humidity_2m,visibility,cloud_cover,pressure_msl"),
            URLQueryItem(name: "forecast_days", value: "7")
        ]
        
        guard let url = components?.url else {
            throw OpenMeteoServiceError.canNotPrepareUrl
        }
        
        return URLRequest(url: url)
    }
}
