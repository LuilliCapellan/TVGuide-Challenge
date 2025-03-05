//
//  SearchFavoritesUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol SearchFavoritesUseCaseProtocol {
    func execute(query: String) -> [FavoriteTVShow]
}

final class SearchFavoritesUseCase: SearchFavoritesUseCaseProtocol {
    private let repository: FavoriteRepository

    init(repository: FavoriteRepository) {
        self.repository = repository
    }

    func execute(query: String) -> [FavoriteTVShow] {
        return repository.searchFavorites(query: query)
    }
}
