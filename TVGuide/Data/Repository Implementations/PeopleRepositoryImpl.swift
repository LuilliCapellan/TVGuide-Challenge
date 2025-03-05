//
//  PeopleRepositoryImpl.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation

final class PeopleRepositoryImpl: PeopleRepository {
    static let shared = PeopleRepositoryImpl()
    private let networkService = NetworkService.shared
    
    private init() {}
    
    func fetchPersonShowCredits(personId: Int) async throws -> [TVShow] {
        let credits: [TVShowCredit] = try await networkService.request(endpoint: "/people/\(personId)/castcredits?embed=show")
        return credits.map { $0.show } // ✅ Extract `TVShow` objects from the response
    }
    
    func fetchPeople(page: Int) async throws -> [Person] {
        return try await networkService.request(endpoint: "/people?page=\(page)")
    }

    func searchPeople(query: String) async throws -> [Person] {
        let results: [PersonSearchResult] = try await networkService.request(endpoint: "/search/people?q=\(query)")
        return results.map { $0.person } // ✅ Extract `Person` objects from search results
    }
}

// Helper Struct for API Response Mapping
struct PersonSearchResult: Codable {
    let person: Person
}
