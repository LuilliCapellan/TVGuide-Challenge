//
//  FavoritesViewModel.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    private let fetchFavoritesUseCase: FetchFavoritesUseCaseProtocol
    private let addFavoriteUseCase: AddFavoriteUseCaseProtocol
    private let removeFavoriteUseCase: RemoveFavoriteUseCaseProtocol
    private let searchFavoritesUseCase: SearchFavoritesUseCaseProtocol
    private let isFavoriteUseCase: IsFavoriteUseCaseProtocol
    
    @Published var favorites: [FavoriteTVShow] = []
    @Published var searchResults: [FavoriteTVShow] = []
    @Published var searchQuery = "" {
        didSet { performSearch() }
    }
    
    private var searchTask: Task<Void, Never>? // Track debounce task
    
    init(fetchFavoritesUseCase: FetchFavoritesUseCaseProtocol,
         addFavoriteUseCase: AddFavoriteUseCaseProtocol,
         removeFavoriteUseCase: RemoveFavoriteUseCaseProtocol,
         searchFavoritesUseCase: SearchFavoritesUseCaseProtocol,
         isFavoriteUseCase: IsFavoriteUseCaseProtocol) {
        self.fetchFavoritesUseCase = fetchFavoritesUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
        self.searchFavoritesUseCase = searchFavoritesUseCase
        self.isFavoriteUseCase = isFavoriteUseCase
    }
    
    func fetchFavorites() {
        let realmFavorites = fetchFavoritesUseCase.execute()
        
        let favoriteStructs = realmFavorites.map { FavoriteTVShow(value: $0) }
        
        self.favorites = favoriteStructs
    }
    
    func addFavorite(tvShow: TVShow) {
        addFavoriteUseCase.execute(tvShow: tvShow)
    }
    
    func removeFavorite(tvShowId: Int) {
        removeFavoriteUseCase.execute(tvShowId: tvShowId)
    }
    
    func performSearch() {
        guard !searchQuery.isEmpty else {
            searchResults = []
            return
        }
        searchResults = searchFavoritesUseCase.execute(query: searchQuery)
    }
    
    func toggleFavorite(for show: TVShow)  {
        let isFav = isFavorite(showId: show.id)
        if isFav {
            removeFavorite(tvShowId: show.id)
        } else {
            addFavorite(tvShow: show)
        }
    }
    
    func isFavorite(showId: Int) -> Bool {
        return isFavoriteUseCase.execute(tvShowId: showId)
    }
}
