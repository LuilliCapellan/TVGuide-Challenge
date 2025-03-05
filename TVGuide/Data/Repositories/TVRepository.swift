//
//  TVRepository.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//


protocol TVRepository {
    func fetchTVShows(page: Int) async throws -> [TVShow]
    func searchTVShows(query: String) async throws -> [TVShow]
    func fetchTVShowDetails(id: Int) async throws -> TVShow
    func fetchEpisodesByShow(id: Int) async throws -> [Episode]
}
