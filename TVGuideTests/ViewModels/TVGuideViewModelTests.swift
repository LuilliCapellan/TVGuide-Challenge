//
//  TVGuideViewModelTests.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/5/25.
//

import XCTest
@testable import TVGuide
import Combine

final class TVGuideViewModelTests: XCTestCase {
    var viewModel: TVGuideViewModel!
    var mockFetchTVShowsUseCase: MockFetchTVShowsUseCase!
    var mockSearchTVShowsUseCase: MockSearchTVShowsUseCase!

    override func setUp() {
        super.setUp()
        mockFetchTVShowsUseCase = MockFetchTVShowsUseCase()
        mockSearchTVShowsUseCase = MockSearchTVShowsUseCase()
        viewModel = TVGuideViewModel(
            fetchTVShowsUseCase: mockFetchTVShowsUseCase,
            searchTVShowsUseCase: mockSearchTVShowsUseCase
        )
    }

    override func tearDown() {
        viewModel = nil
        mockFetchTVShowsUseCase = nil
        mockSearchTVShowsUseCase = nil
        super.tearDown()
    }

    /// ✅ Test fetching TV shows successfully
    func testFetchTVShowsSuccess() async {
        // Given
        let tvShowOne = TVShow(id: 1, name: "Breaking Bad", schedule: nil, summary: "A teacher turns into a meth producer.", image: nil, genres: [], embedded: nil)
        let tvShowTwo = TVShow(id: 2, name: "Stranger Things", schedule: nil, summary: "Kids uncover supernatural mysteries.", image: nil, genres: [], embedded: nil)
        mockFetchTVShowsUseCase.mockTVShows = [tvShowOne, tvShowTwo]

        // When
        await viewModel.fetchTVShows()

        // Then
        XCTAssertEqual(viewModel.tvShows.count, 2)
        XCTAssertEqual(viewModel.tvShows.first?.name, "Breaking Bad")
        XCTAssertEqual(viewModel.tvShows.last?.name, "Stranger Things")
        XCTAssertFalse(viewModel.isLoading)
    }

    /// ✅ Test API failure when fetching TV shows
    func testFetchTVShowsFailure() async {
        // Given
        mockFetchTVShowsUseCase.shouldThrowError = true

        // When
        await viewModel.fetchTVShows()

        // Then
        XCTAssertTrue(viewModel.tvShows.isEmpty) // Should not populate on failure
        XCTAssertFalse(viewModel.isLoading)
    }

    /// ✅ Test searching TV shows successfully
    func testSearchTVShowsSuccess() async {
        // Given
        let searchResult = TVShow(id: 3, name: "Game of Thrones", schedule: nil, summary: "Noble families fight for power.", image: nil, genres: [], embedded: nil)
        mockSearchTVShowsUseCase.mockSearchResults = [searchResult]

        // When
        await viewModel.performSearch(query: "Game")

        // Then
        XCTAssertEqual(viewModel.searchResults.count, 1)
        XCTAssertEqual(viewModel.searchResults.first?.name, "Game of Thrones")
    }

    /// ✅ Test API failure when searching TV shows
    func testSearchTVShowsFailure() async {
        // Given
        mockSearchTVShowsUseCase.shouldThrowError = true

        // When
        await viewModel.performSearch(query: "Game")

        // Then
        XCTAssertTrue(viewModel.searchResults.isEmpty) // Should not populate on failure
    }

    /// ✅ Test search resets when query is empty
    func testSearchClearsResultsOnEmptyQuery() {
        // Given
        viewModel.searchResults = [TVShow(id: 4, name: "House of Cards", schedule: nil, summary: nil, image: nil, genres: [], embedded: nil)]
        
        // When
        let expectation = expectation(description: "Waiting for search results to be cleared")
        
        var cancellable: AnyCancellable?
        cancellable = viewModel.$searchResults
            .dropFirst() // Ignore initial value
            .sink { results in
                if results.isEmpty {
                    expectation.fulfill()
                    cancellable?.cancel()
                }
            }
        
        viewModel.searchQuery = ""

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(viewModel.searchResults.isEmpty)
    }
}
