//
//  RemoveFavoriteUseCase.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol RemoveFavoriteUseCaseProtocol {
    func execute(tvShowId: Int)
}

final class RemoveFavoriteUseCase: RemoveFavoriteUseCaseProtocol {
    private let repository: FavoriteRepository
    
    init(repository: FavoriteRepository) {
        self.repository = repository
    }
    
    func execute(tvShowId: Int) {
        repository.removeFavorite(tvShowId: tvShowId)
    }
}
