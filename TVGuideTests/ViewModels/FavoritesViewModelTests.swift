//
//  FavoritesViewModelTests.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/5/25.
//

import XCTest
@testable import TVGuide

final class FavoritesViewModelTests: XCTestCase {
    
    // Mock Use Cases
    private var mockFetchFavoritesUseCase: MockFetchFavoritesUseCase!
    private var mockAddFavoriteUseCase: MockAddFavoriteUseCase!
    private var mockRemoveFavoriteUseCase: MockRemoveFavoriteUseCase!
    private var mockSearchFavoritesUseCase: MockSearchFavoritesUseCase!
    private var mockIsFavoriteUseCase: MockIsFavoriteUseCase!
    
    private var viewModel: FavoritesViewModel!
    
    override func setUp() {
        super.setUp()
        
        mockFetchFavoritesUseCase = MockFetchFavoritesUseCase()
        mockAddFavoriteUseCase = MockAddFavoriteUseCase()
        mockRemoveFavoriteUseCase = MockRemoveFavoriteUseCase()
        mockSearchFavoritesUseCase = MockSearchFavoritesUseCase()
        mockIsFavoriteUseCase = MockIsFavoriteUseCase()
        
        viewModel = FavoritesViewModel(
            fetchFavoritesUseCase: mockFetchFavoritesUseCase,
            addFavoriteUseCase: mockAddFavoriteUseCase,
            removeFavoriteUseCase: mockRemoveFavoriteUseCase,
            searchFavoritesUseCase: mockSearchFavoritesUseCase,
            isFavoriteUseCase: mockIsFavoriteUseCase
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockFetchFavoritesUseCase = nil
        mockAddFavoriteUseCase = nil
        mockRemoveFavoriteUseCase = nil
        mockSearchFavoritesUseCase = nil
        mockIsFavoriteUseCase = nil
        super.tearDown()
    }
    
    // ✅ Test adding a favorite
    func testAddFavorite() {
        // Given
        let newShow = TVShow(id: 3, name: "Game of Thrones", schedule: nil, summary: "Fantasy drama", image: nil, genres: [], embedded: nil)
        
        // When
        viewModel.addFavorite(tvShow: newShow)
        
        // Then
        XCTAssertTrue(mockAddFavoriteUseCase.didCallExecute)
    }
    
    // ✅ Test removing a favorite
    func testRemoveFavorite() {
        // Given
        let showIdToRemove = 1
        
        // When
        viewModel.removeFavorite(tvShowId: showIdToRemove)
        
        // Then
        XCTAssertTrue(mockRemoveFavoriteUseCase.didCallExecute)
    }
    
    // ✅ Test searching favorites
    func testSearchFavorites() {
        // Given
        let query = "Breaking"
        let favoriteTVShow = FavoriteTVShow()
        favoriteTVShow.id = 1
        favoriteTVShow.name = "Breaking Bad"
        let searchResults = [
            favoriteTVShow
        ]
        mockSearchFavoritesUseCase.mockResults = searchResults
        
        // When
        viewModel.searchQuery = query
        
        // Then
        XCTAssertEqual(viewModel.searchResults, searchResults)
    }
    
    // ✅ Test checking if a show is a favorite
    func testIsFavorite() {
        // Given
        let showId = 1
        mockIsFavoriteUseCase.mockResult = true
        
        // When
        let result = viewModel.isFavorite(showId: showId)
        
        // Then
        XCTAssertTrue(result)
    }
    
    // ✅ Test toggling favorite
    func testToggleFavorite_Add() {
        // Given
        let show = TVShow(id: 3, name: "Game of Thrones", schedule: nil, summary: "Fantasy drama", image: nil, genres: [], embedded: nil)
        mockIsFavoriteUseCase.mockResult = false // Not a favorite yet
        
        // When
        viewModel.toggleFavorite(for: show)
        
        // Then
        XCTAssertTrue(mockAddFavoriteUseCase.didCallExecute)
    }
    
    func testToggleFavorite_Remove() {
        // Given
        let show = TVShow(id: 1, name: "Breaking Bad", schedule: nil, summary: "Crime drama", image: nil, genres: [], embedded: nil)
        mockIsFavoriteUseCase.mockResult = true // Already a favorite
        
        // When
        viewModel.toggleFavorite(for: show)
        
        // Then
        XCTAssertTrue(mockRemoveFavoriteUseCase.didCallExecute)
    }
}
