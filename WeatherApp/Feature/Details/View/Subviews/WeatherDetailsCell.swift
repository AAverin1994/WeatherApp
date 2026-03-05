//
//  WeatherDetailsCell.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import SwiftUI

struct WeatherDetailsCell: View {
    let details: WeatherDayDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Text(formateDate(details.date))
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Tempreture: \(details.tempreture)")
                    .foregroundStyle(Color.gray)
            }

            VStack(alignment: .leading) {
                textSection(key: "Pressure: ", description: details.pressure)
                textSection(key: "Humidity: ", description: details.humidity)
                textSection(key: "Visibility: ", description: details.visibility)
                textSection(key: "Cloud cover: ", description: details.cloudCover)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(Color.cyan.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
    
    private func formateDate(_ date: Date) -> String {
        date.formatted(.dateTime.day().month(.wide))
    }
    
    @ViewBuilder private func textSection(key: String, description: String) -> some View {
        Text(key).fontWeight(.medium) + Text(description)
    }
}
