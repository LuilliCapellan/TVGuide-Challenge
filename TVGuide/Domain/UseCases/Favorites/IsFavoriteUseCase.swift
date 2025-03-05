//
//  IsFavoriteUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol IsFavoriteUseCaseProtocol {
    func execute(tvShowId: Int)  -> Bool
}

final class IsFavoriteUseCase: IsFavoriteUseCaseProtocol {
    private let repository: FavoriteRepository

    init(repository: FavoriteRepository) {
        self.repository = repository
    }

    func execute(tvShowId: Int) -> Bool {
        return repository.isFavorite(tvShowId: tvShowId)
    }
}
