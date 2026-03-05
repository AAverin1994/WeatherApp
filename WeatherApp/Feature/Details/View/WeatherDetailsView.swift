//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import SwiftUI

struct WeatherDetailsView: View {
    @StateObject var viewModel: WeatherDetailsViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.error {
                Text("Error: \(error)")
            } else if let weekWeather = viewModel.weekWeather {
                ScrollView {
                    ForEach(weekWeather.details) {
                        WeatherDetailsCell(details: $0)
                            .padding(.bottom, 12)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .refreshable {
                    viewModel.loadWeekWeather(isRefreshable: true)
                }
            } else {
                Text("No information")
            }
        }
        .navigationTitle(navigationTitle)
        .onAppear {
            viewModel.loadWeekWeather()
        }
    }
    
    private var navigationTitle: String {
        let city = viewModel.weekWeather?.city ?? ""
        return "\(city) weather forecast for the week"
    }
}
