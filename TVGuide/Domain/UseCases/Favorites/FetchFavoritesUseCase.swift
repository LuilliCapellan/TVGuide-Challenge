//
//  FetchFavoritesUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol FetchFavoritesUseCaseProtocol {
    func execute() -> [FavoriteTVShow]
}

final class FetchFavoritesUseCase: FetchFavoritesUseCaseProtocol {
    private let repository: FavoriteRepository

    init(repository: FavoriteRepository) {
        self.repository = repository
    }

    func execute() -> [FavoriteTVShow] {
        return repository.fetchFavorites()
    }
}
