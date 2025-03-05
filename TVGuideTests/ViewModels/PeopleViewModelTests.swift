//
//  PeopleViewModelTests.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/5/25.
//

import XCTest
@testable import TVGuide

final class PeopleViewModelTests: XCTestCase {
    private var viewModel: PeopleViewModel!
    private var mockFetchPeopleUseCase: MockFetchPeopleUseCase!
    
    override func setUp() {
        super.setUp()
        mockFetchPeopleUseCase = MockFetchPeopleUseCase()
        viewModel = PeopleViewModel(fetchPeopleUseCase: mockFetchPeopleUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockFetchPeopleUseCase = nil
        super.tearDown()
    }

    // ✅ Test Initial State
    func testInitialState() {
        XCTAssertTrue(viewModel.people.isEmpty)
        XCTAssertTrue(viewModel.searchResults.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.currentPage, 0)
        XCTAssertEqual(viewModel.searchQuery, "")
    }

    // ✅ Test Fetching People Successfully
    func testFetchPeopleSuccess() async {
        // Given
        let person1 = Person(id: 1, name: "John Doe", country: nil, image: nil)
        let person2 = Person(id: 2, name: "Jane Smith", country: nil, image: nil)
        mockFetchPeopleUseCase.mockPeople = [person1, person2]

        // When
        await viewModel.fetchPeople()

        // Then
        XCTAssertEqual(viewModel.people, [person1, person2])
        XCTAssertEqual(viewModel.currentPage, 1) // Page should increment
        XCTAssertFalse(viewModel.isLoading)
    }

    // ✅ Test Fetching People with Error Handling
    func testFetchPeopleFailure() async {
        // Given
        mockFetchPeopleUseCase.shouldThrowError = true

        // When
        await viewModel.fetchPeople()

        // Then
        XCTAssertTrue(viewModel.people.isEmpty) // Should remain empty
        XCTAssertFalse(viewModel.isLoading)
    }

    // ✅ Test Searching People Successfully
    func testSearchPeopleSuccess() async {
        // Given
        let searchPerson = Person(id: 3, name: "Lauren Miller", country: nil, image: nil)
        mockFetchPeopleUseCase.mockSearchResults = [searchPerson]

        // When
        viewModel.searchQuery = "Lauren"
        try? await Task.sleep(nanoseconds: 500_000_000) // Wait for debounce

        // Then
        XCTAssertEqual(viewModel.searchResults, [searchPerson])
    }

    // ✅ Test Searching People with Empty Query
    func testSearchWithEmptyQuery() async {
        // Given
        viewModel.searchQuery = ""

        // When
        try? await Task.sleep(nanoseconds: 500_000_000) // Wait for debounce

        // Then
        XCTAssertTrue(viewModel.searchResults.isEmpty)
    }

    // ✅ Test Search Failure Handling
    func testSearchPeopleFailure() async {
        // Given
        mockFetchPeopleUseCase.shouldThrowError = true

        // When
        viewModel.searchQuery = "ErrorTest"
        try? await Task.sleep(nanoseconds: 500_000_000) // Wait for debounce

        // Then
        XCTAssertTrue(viewModel.searchResults.isEmpty)
    }
}
