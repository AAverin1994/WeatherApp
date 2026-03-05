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
        
        log(data)
        
        guard
            let response = response as? HTTPURLResponse,
            200 ... 299 ~= response.statusCode
        else {
            throw ApiClientError.unvalidRequest
        }
        
        return try TaoDecoder().decode(T.self, from: data)
    }
    
    private func log(_ data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
    }
}
