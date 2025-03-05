//
//  FetchPeopleUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol FetchPeopleUseCaseProtocol {
    func execute(page: Int) async throws -> [Person]
    func search(query: String) async throws -> [Person]
}

final class FetchPeopleUseCase: FetchPeopleUseCaseProtocol {
    private let repository: PeopleRepository

    init(repository: PeopleRepository = PeopleRepositoryImpl.shared) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> [Person] {
        return try await repository.fetchPeople(page: page)
    }

    func search(query: String) async throws -> [Person] {
        return try await repository.searchPeople(query: query)
    }
}
