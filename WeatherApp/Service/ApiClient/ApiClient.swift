//
//  ApiClient.swift
//  WeatherApp
//
//  Created by Andrey on 05.03.2026.
//

import Foundation

enum ApiClientError: Error {
    case unvalidRequest
}

final class ApiClient {
    private let apiService = URLSession.shared
    
    func execute<T: TaoDecodable>(request: URLRequest) async throws -> T {
        let (data, response) = try await apiService.data(for: request)

        guard
            let response = response as? HTTPURLResponse,
            200 ... 299 ~= response.statusCode
        else {
            throw ApiClientError.unvalidRequest
        }
        
        return try TaoDecoder().decode(T.self, from: data)
    }
}
