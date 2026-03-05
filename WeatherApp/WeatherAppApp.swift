//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Andrey on 03.03.2026.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                viewModel: MainViewModel(
                    service: OpenMeteoService()
                )
            )
        }
    }
}
