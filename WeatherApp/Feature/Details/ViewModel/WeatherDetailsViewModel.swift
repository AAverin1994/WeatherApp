//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import SwiftUI

final class WeatherDetailsViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var weekWeather: WeatherDetails?
    @Published private(set) var error: Error?
    
    private let service: WeatherService
    private let cityWeather: MainWeather
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init(
        cityWeather: MainWeather,
        service: WeatherService
    ) {
        self.cityWeather = cityWeather
        self.service = service
    }

    func loadWeekWeather(isRefreshable: Bool = false) {
        Task { @MainActor in
            isLoading = !isRefreshable
            
            defer {
                isLoading = false
            }
            
            do {
                let forecast = try await service.getWeekWeather(
                    geocoding: cityWeather.geocoding
                ).forecast
                
                guard
                    let hourly = forecast.hourly,
                    let hourlyUnits = forecast.hourlyUnits
                else {
                    return
                }
                
                weekWeather = WeatherDetails(
                    city: cityWeather.geocoding.name,
                    details: prepareWeatherDayDetails(
                        hourly: hourly,
                        units: hourlyUnits
                    )
                )
            } catch {
                self.error = error
            }
        }
    }
    
    private func prepareWeatherDayDetails(
        hourly: HourlyWeather,
        units: HourlyUnits
    ) -> [WeatherDayDetails] {
        var indexedTimes: [String: [Int]] = [:]

        for (index, time) in hourly.time.enumerated() {
            let day = String(time.prefix(10)) // remove time from date
            indexedTimes[day, default: []].append(index)
        }

        return indexedTimes.compactMap { date, indexes in
            func average(_ values: [Double]) -> Double {
                guard values.count > 0 else {
                    return 0
                }

                return values.reduce(0, +) / Double(values.count)
            }
            
            guard let formattedDate = dateFormatter.date(from: date) else {
                return nil
            }
            
            let tempreture = floor(average(indexes.map { hourly.temperature[$0] }))
            let pressure = floor(average(indexes.map { hourly.pressure[$0] }))
            let humidity = floor(average(indexes.map { hourly.humidity[$0] }))
            let visibility = floor(average(indexes.map { hourly.visibility[$0] }))
            let cloudCover = floor(average(indexes.map { hourly.cloudCover[$0] }))
            
            return WeatherDayDetails(
                date: formattedDate,
                tempreture: "\(tempreture) \(units.tempretureUnits)",
                pressure: "\(pressure) \(units.pressureUnits)",
                humidity: "\(humidity) \(units.humidityUnits)",
                visibility: "\(visibility) \(units.visibilityUnits)",
                cloudCover: "\(cloudCover) \(units.cloudCoverUnits)"
            )
        }.sorted { $0.date < $1.date }
    }
}
