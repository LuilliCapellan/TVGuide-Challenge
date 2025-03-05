//
//  FetchShowEpisodesUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol FetchShowEpisodesUseCaseProtocol {
    func execute(showId: Int) async throws -> [Episode]
}

final class FetchShowEpisodesUseCase: FetchShowEpisodesUseCaseProtocol {
    private let repository: TVRepository

    init(repository: TVRepository) {
        self.repository = repository
    }

    func execute(showId: Int) async throws -> [Episode] {
        return try await repository.fetchEpisodesByShow(id: showId)
    }
}
