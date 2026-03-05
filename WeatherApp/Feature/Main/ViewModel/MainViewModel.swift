//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Andrey on 03.03.2026.
//

import Foundation

enum MainViewModelError: Error {
    case canNotParseParameters
}

private let TempretureLimit: Double = 10

final class MainViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var weathers: [MainWeather] = []
    @Published private(set) var error: Error?
    
    private lazy var dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return formatter
    }()

    private let service: WeatherService

    init(service: WeatherService) {
        self.service = service
    }

    func loadWeather() {
        Task { @MainActor in
            isLoading = true
            
            defer {
                isLoading = false
            }
            
            do {
                let weathers = try await service.getWeathers(
                    countries: Country.allCases
                )
                
                self.weathers = weathers.compactMap { try? parse($0) }
            } catch {
                self.error = error
            }
        }
    }

    func updateWeather(_ index: Int) {
        Task { @MainActor in
            var updatingWeathers = weathers
            
            guard
                let updatedWeather = try? await service.getWeather(
                    geocoding: updatingWeathers[index].geocoding
                ),
                let parsedWeather = try? parse(updatedWeather)
            else {
                return
            }
            
            updatingWeathers[index] = parsedWeather
            self.weathers = updatingWeathers
        }
    }
    
    private func parse(_ result: WeatherResult) throws -> MainWeather {
        guard
            let current = result.forecast.currentWeather,
            let currentUnits = result.forecast.currentWeatherUnits,
            let date = dateFormatter.date(from: current.time)
        else {
            throw MainViewModelError.canNotParseParameters
        }

        return MainWeather(
            city: result.geocoding.name,
            date: date,
            isLowerTempreture: current.temperature < TempretureLimit,
            tempreture: "\(floor(current.temperature)) \(currentUnits.temperature)",
            windspeed: "\(floor(current.windspeed)) \(currentUnits.windspeed)",
            windDirection: "\(current.winddirection) \(currentUnits.winddirection)",
            geocoding: result.geocoding
        )
    }
}
