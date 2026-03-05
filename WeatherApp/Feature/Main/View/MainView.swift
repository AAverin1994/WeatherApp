//
//  MainView.swift
//  WeatherApp
//
//  Created by Andrey on 03.03.2026.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.error {
                    Text("Error: \(error)")
                    Button("Retry", action: viewModel.loadWeather)
                } else {                    
                    if viewModel.weathers.count > 0 {
                        ScrollView {
                            ForEach(Array(viewModel.weathers.enumerated()), id: \.element.id) { item in
                                weatherSection(
                                    weather: item.element,
                                    index: item.offset
                                )
                                .padding(.bottom, 12)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        }
                    } else {
                        Text("No data")
                    }
                }
            }
        }
        .onAppear(perform: viewModel.loadWeather)
    }
    
    @ViewBuilder private func weatherSection(
        weather: MainWeather,
        index: Int
    ) -> some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Text("\(weather.geocoding.name)")
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(weather.date, format: .dateTime.day().month().hour().minute())
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.gray)
            }
            
            NavigationLink(
                destination: WeatherDetailsView(
                    viewModel: WeatherDetailsViewModel(
                        cityWeather: weather,
                        service: OpenMeteoService()
                    )
                )
            ) {
                WeatherCell(weather: weather) {
                    viewModel.updateWeather(index)
                }
            }
        }
    }
}
