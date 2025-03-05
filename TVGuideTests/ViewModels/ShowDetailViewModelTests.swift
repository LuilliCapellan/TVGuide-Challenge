//
//  ShowDetailViewModelTests.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/5/25.
//

import XCTest
@testable import TVGuide

final class ShowDetailViewModelTests: XCTestCase {
    private var viewModel: ShowDetailViewModel!
    private var mockFetchShowDetailsUseCase: MockFetchShowDetailsUseCase!
    private var mockFetchShowEpisodesUseCase: MockFetchShowEpisodesUseCase!

    override func setUp() {
        super.setUp()
        mockFetchShowDetailsUseCase = MockFetchShowDetailsUseCase()
        mockFetchShowEpisodesUseCase = MockFetchShowEpisodesUseCase()
        viewModel = ShowDetailViewModel(
            fetchShowDetailsUseCase: mockFetchShowDetailsUseCase,
            fetchShowEpisodesUseCase: mockFetchShowEpisodesUseCase
        )
    }

    override func tearDown() {
        viewModel = nil
        mockFetchShowDetailsUseCase = nil
        mockFetchShowEpisodesUseCase = nil
        super.tearDown()
    }

    // ✅ Test Initial State
    func testInitialState() {
        XCTAssertNil(viewModel.show)
        XCTAssertTrue(viewModel.episodesBySeason.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    // ✅ Test Successful Fetching of Show Details and Episodes
    func testLoadShowDetailsSuccess() async {
        // Given
        let mockShow = TVShow(
            id: 1,
            name: "Breaking Bad",
            schedule: nil,
            summary: "A high school chemistry teacher turned meth producer.",
            image: nil,
            genres: [],
            embedded: nil
        )

        let episode1 = Episode(
            id: 101,
            name: "Pilot",
            season: 1,
            number: 1,
            airdate: "2008-01-20",
            airtime: "22:00",
            runtime: 58,
            rating: Episode.Rating(average: 9.0),
            image: nil,
            summary: "Walter White starts cooking meth."
        )

        let episode2 = Episode(
            id: 102,
            name: "Cat's in the Bag",
            season: 1,
            number: 2,
            airdate: "2008-01-27",
            airtime: "22:00",
            runtime: 48,
            rating: Episode.Rating(average: 8.7),
            image: nil, 
            summary: "Walter and Jesse deal with a situation."
        )
        
        mockFetchShowDetailsUseCase.mockShow = mockShow
        mockFetchShowEpisodesUseCase.mockEpisodes = [episode1, episode2]

        // When
        await viewModel.loadShowDetails(showId: 1)

        // Then
        XCTAssertEqual(viewModel.show, mockShow)
        XCTAssertEqual(viewModel.episodesBySeason[1], [episode1, episode2])
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    // ✅ Test Failure Fetching Show Details
    func testLoadShowDetailsFailure() async {
        // Given
        mockFetchShowDetailsUseCase.shouldThrowError = true

        // When
        await viewModel.loadShowDetails(showId: 1)

        // Then
        XCTAssertNil(viewModel.show) // Show should remain nil
        XCTAssertTrue(viewModel.episodesBySeason.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    // ✅ Test Failure Fetching Episodes
    func testLoadShowEpisodesFailure() async {
        // Given
        let mockShow = TVShow(id: 1, name: "Breaking Bad", schedule: nil, summary: "A high school chemistry teacher turned meth producer.", image: nil, genres: [], embedded: nil)
        mockFetchShowDetailsUseCase.mockShow = mockShow
        mockFetchShowEpisodesUseCase.shouldThrowError = true

        // When
        await viewModel.loadShowDetails(showId: 1)

        // Then
        XCTAssertEqual(viewModel.show, mockShow)
        XCTAssertTrue(viewModel.episodesBySeason.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
