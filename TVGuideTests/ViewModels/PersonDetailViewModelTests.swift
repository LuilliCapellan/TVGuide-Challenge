//
//  PersonDetailViewModelTests.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/5/25.
//

import XCTest
@testable import TVGuide

final class PersonDetailViewModelTests: XCTestCase {
    private var viewModel: PersonDetailViewModel!
    private var mockUseCase: MockFetchPersonShowCreditsUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchPersonShowCreditsUseCase()
        viewModel = PersonDetailViewModel(fetchPersonShowCreditsUseCase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    // ✅ Test Initial State
    func testInitialState() {
        XCTAssertTrue(viewModel.tvShowCredits.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // ✅ Test Fetching Show Credits Successfully
    func testFetchPersonShowCreditsSuccess() async {
        // Given
        let show1 = TVShow(id: 1, name: "Breaking Bad", schedule: nil, summary: "A high school chemistry teacher turned meth producer.", image: nil, genres: [], embedded: nil)
        let show2 = TVShow(id: 2, name: "Better Call Saul", schedule: nil, summary: "The story of Saul Goodman before Breaking Bad.", image: nil, genres: [], embedded: nil)
        mockUseCase.mockShows = [show1, show2]
        
        // When
        await viewModel.fetchPersonShowCredits(personId: 123)
        
        // Then
        XCTAssertEqual(viewModel.tvShowCredits, [show1, show2])
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // ✅ Test Fetching Show Credits Fails
    func testFetchPersonShowCreditsFailure() async {
        // Given
        mockUseCase.shouldThrowError = true
        
        // When
        await viewModel.fetchPersonShowCredits(personId: 123)
        
        // Then
        XCTAssertTrue(viewModel.tvShowCredits.isEmpty) // No data should be added
        XCTAssertFalse(viewModel.isLoading)
    }
}
