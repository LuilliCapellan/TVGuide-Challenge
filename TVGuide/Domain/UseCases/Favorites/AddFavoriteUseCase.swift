//
//  AddFavoriteUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol AddFavoriteUseCaseProtocol {
    func execute(tvShow: TVShow)
}

final class AddFavoriteUseCase: AddFavoriteUseCaseProtocol {
    private let repository: FavoriteRepository

    init(repository: FavoriteRepository) {
        self.repository = repository
    }

    func execute(tvShow: TVShow) {
        repository.addFavorite(tvShow)
    }
}
