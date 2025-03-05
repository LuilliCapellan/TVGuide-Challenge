//
//  RepositoryContainer.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Combine

class RepositoryContainer: ObservableObject {
    let tvRepository: TVRepository
    let peopleRepository: PeopleRepository
    let favoriteRepository: FavoriteRepository

    init(
        tvRepository: TVRepository = TVRepositoryImpl.shared,
        peopleRepository: PeopleRepository = PeopleRepositoryImpl.shared,
        favoriteRepository: FavoriteRepository = FavoriteRepositoryImpl()
    ) {
        self.tvRepository = tvRepository
        self.peopleRepository = peopleRepository
        self.favoriteRepository = favoriteRepository
    }
}
