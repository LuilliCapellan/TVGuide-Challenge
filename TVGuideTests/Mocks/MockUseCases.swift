//
//  MockUseCases.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/5/25.
//

import XCTest
import Combine
@testable import TVGuide

final class MockFetchTVShowsUseCase: FetchTVShowsUseCaseProtocol {
    var mockTVShows: [TVShow] = []
    var shouldThrowError = false

    func execute(page: Int) async throws -> [TVShow] {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return mockTVShows
    }
}

final class MockSearchTVShowsUseCase: SearchTVShowsUseCaseProtocol {
    var mockSearchResults: [TVShow] = []
    var shouldThrowError = false

    func execute(query: String) async throws -> [TVShow] {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return mockSearchResults
    }
}

final class MockFetchShowDetailsUseCase: FetchShowDetailsUseCaseProtocol {
    var mockShow: TVShow?
    var shouldThrowError = false

    func execute(showId: Int) async throws -> TVShow {
        if shouldThrowError { throw URLError(.badServerResponse) }
        guard let show = mockShow else { throw URLError(.badURL) }
        return show
    }
}

final class MockFetchShowEpisodesUseCase: FetchShowEpisodesUseCaseProtocol {
    var mockEpisodes: [Episode] = []
    var shouldThrowError = false

    func execute(showId: Int) async throws -> [Episode] {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return mockEpisodes
    }
}

final class MockFetchPersonShowCreditsUseCase: FetchPersonShowCreditsUseCaseProtocol {
    var mockShows: [TVShow] = []
    var shouldThrowError = false

    func execute(personId: Int) async throws -> [TVShow] {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return mockShows
    }
}

final class MockFetchPeopleUseCase: FetchPeopleUseCaseProtocol {
    var mockPeople: [Person] = []
    var mockSearchResults: [Person] = []
    var shouldThrowError = false

    func execute(page: Int) async throws -> [Person] {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return mockPeople
    }

    func search(query: String) async throws -> [Person] {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return mockSearchResults
    }
}

final class MockFetchFavoritesUseCase: FetchFavoritesUseCaseProtocol {
    var mockFavorites: [FavoriteTVShow] = []
    
    func execute() -> [FavoriteTVShow] {
        return mockFavorites
    }
}

final class MockAddFavoriteUseCase: AddFavoriteUseCaseProtocol {
    var didCallExecute = false
    
    func execute(tvShow: TVShow) {
        didCallExecute = true
    }
}

final class MockRemoveFavoriteUseCase: RemoveFavoriteUseCaseProtocol {
    var didCallExecute = false
    
    func execute(tvShowId: Int) {
        didCallExecute = true
    }
}

final class MockSearchFavoritesUseCase: SearchFavoritesUseCaseProtocol {
    var mockResults: [FavoriteTVShow] = []
    
    func execute(query: String) -> [FavoriteTVShow] {
        return mockResults
    }
}

final class MockIsFavoriteUseCase: IsFavoriteUseCaseProtocol {
    var mockResult = false
    
    func execute(tvShowId: Int) -> Bool {
        return mockResult
    }
}
