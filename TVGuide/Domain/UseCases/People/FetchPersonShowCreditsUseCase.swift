//
//  FetchPersonShowCreditsUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/4/25.
//


protocol FetchPersonShowCreditsUseCaseProtocol {
    func execute(personId: Int) async throws -> [TVShow]
}

final class FetchPersonShowCreditsUseCase: FetchPersonShowCreditsUseCaseProtocol {
    private let repository: PeopleRepository

    init(repository: PeopleRepository) {
        self.repository = repository
    }

    func execute(personId: Int) async throws -> [TVShow] {
        return try await repository.fetchPersonShowCredits(personId: personId)
    }
}
