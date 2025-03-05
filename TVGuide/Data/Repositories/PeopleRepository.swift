//
//  PeopleRepository.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol PeopleRepository {
    func fetchPersonShowCredits(personId: Int) async throws -> [TVShow]
    func fetchPeople(page: Int) async throws -> [Person]
    func searchPeople(query: String) async throws -> [Person]
}
