//
//  TVRepositoryImpl.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation

final class TVRepositoryImpl: TVRepository {
    static let shared = TVRepositoryImpl()
    private let networkService = NetworkService.shared

    private init() {}

    func fetchTVShows(page: Int) async throws -> [TVShow] {
        let endpoint = "/shows?page=\(page)"
        return try await networkService.request(endpoint: endpoint)
    }

    func searchTVShows(query: String) async throws -> [TVShow] {
        let endpoint = "/search/shows?q=\(query)"
        let results: [TVShowSearchResult] = try await networkService.request(endpoint: endpoint)
        return results.map { $0.show }
    }

    func fetchTVShowDetails(id: Int) async throws -> TVShow {
        let endpoint = "/shows/\(id)?embed=cast"
        return try await networkService.request(endpoint: endpoint)
    }

    func fetchEpisodesByShow(id: Int) async throws -> [Episode] {
        let endpoint = "/shows/\(id)/episodes"
        return try await networkService.request(endpoint: endpoint)
    }
}
