//
//  FetchShowDetailsUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol FetchShowDetailsUseCaseProtocol {
    func execute(showId: Int) async throws -> TVShow
}

final class FetchShowDetailsUseCase: FetchShowDetailsUseCaseProtocol {
    private let repository: TVRepository

    init(repository: TVRepository) {
        self.repository = repository
    }

    func execute(showId: Int) async throws -> TVShow {
        return try await repository.fetchTVShowDetails(id: showId)
    }
}
