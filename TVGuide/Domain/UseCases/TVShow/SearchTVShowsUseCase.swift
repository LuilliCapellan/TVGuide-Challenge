//
//  SearchTVShowsUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol SearchTVShowsUseCaseProtocol {
    func execute(query: String) async throws -> [TVShow]
}

final class SearchTVShowsUseCase: SearchTVShowsUseCaseProtocol {
    private let repository: TVRepository

    init(repository: TVRepository) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [TVShow] {
        return try await repository.searchTVShows(query: query)
    }
}
