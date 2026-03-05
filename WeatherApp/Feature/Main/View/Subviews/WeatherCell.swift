//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import SwiftUI

struct WeatherCell: View {
    let weather: MainWeather
    let onUpdate: () -> Void
    
    @State private var isUpdating: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Tempreture:")
                        .foregroundStyle(.black)
                    
                    Text("\(weather.tempreture)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(weather.isLowerTempreture ? .red : .black)
                }
                
                VStack(alignment: .trailing, spacing: 8) {
                    textSection(
                        key: "Wind direction: ",
                        description: "\(weather.windDirection)"
                    )
                    .foregroundStyle(.black)
                    
                    textSection(
                        key: "Wind speed: ",
                        description: "\(weather.windspeed)"
                    )
                    .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity, alignment: .topTrailing)
            }

            Button(isUpdating ? "Updating..." : "Update") {
                isUpdating = true
                
                onUpdate()
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue)
            )
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(16)
        .background(Color.blue.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    @ViewBuilder private func textSection(key: String, description: String) -> some View {
        Text(key).fontWeight(.medium) + Text(description)
    }
}
