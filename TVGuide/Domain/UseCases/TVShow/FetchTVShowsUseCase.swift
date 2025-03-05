//
//  FetchTVShowsUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol FetchTVShowsUseCaseProtocol {
    func execute(page: Int) async throws -> [TVShow]
}

final class FetchTVShowsUseCase: FetchTVShowsUseCaseProtocol {
    private let repository: TVRepository

    init(repository: TVRepository) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> [TVShow] {
        return try await repository.fetchTVShows(page: page)
    }
}
