//
//  NetworkService.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://api.tvmaze.com"
    
    private init() {}

    func request<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // Optional if needed
        return try decoder.decode(T.self, from: data)
    }
}
