//
//  ViewModelContainer.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

final class ViewModelContainer: ObservableObject {
    @Published var tvGuideViewModel: TVGuideViewModel
    @Published var showDetailViewModel: ShowDetailViewModel
    @Published var peopleViewModel: PeopleViewModel
    @Published var favoritesViewModel: FavoritesViewModel
    @Published var personDetailViewModel: PersonDetailViewModel
    
    init(repositories: RepositoryContainer) {
        let fetchTVShowsUseCase = FetchTVShowsUseCase(repository: repositories.tvRepository)
        let searchTVShowsUseCase = SearchTVShowsUseCase(repository: repositories.tvRepository)
        let fetchShowDetailsUseCase = FetchShowDetailsUseCase(repository: repositories.tvRepository)
        let fetchShowEpisodesUseCase = FetchShowEpisodesUseCase(repository: repositories.tvRepository)
        let fetchPeopleUseCase = FetchPeopleUseCase(repository: repositories.peopleRepository)
        let fetchFavoritesUseCase = FetchFavoritesUseCase(repository: repositories.favoriteRepository)
        let addFavoriteUseCase = AddFavoriteUseCase(repository: repositories.favoriteRepository)
        let removeFavoriteUseCase = RemoveFavoriteUseCase(repository: repositories.favoriteRepository)
        let searchFavoritesUseCase = SearchFavoritesUseCase(repository: repositories.favoriteRepository)
        let isFavoriteUseCase = IsFavoriteUseCase(repository: repositories.favoriteRepository)
        let fetchPersonShowCreditsUseCase = FetchPersonShowCreditsUseCase(repository: repositories.peopleRepository)
        
        
        self.tvGuideViewModel = TVGuideViewModel(
            fetchTVShowsUseCase: fetchTVShowsUseCase,
            searchTVShowsUseCase: searchTVShowsUseCase
        )
        
        self.showDetailViewModel = ShowDetailViewModel(
            fetchShowDetailsUseCase: fetchShowDetailsUseCase,
            fetchShowEpisodesUseCase: fetchShowEpisodesUseCase
        )
        
        self.peopleViewModel = PeopleViewModel(fetchPeopleUseCase: fetchPeopleUseCase)
        
        self.favoritesViewModel = FavoritesViewModel(
            fetchFavoritesUseCase: fetchFavoritesUseCase,
            addFavoriteUseCase: addFavoriteUseCase,
            removeFavoriteUseCase: removeFavoriteUseCase,
            searchFavoritesUseCase: searchFavoritesUseCase,
            isFavoriteUseCase: isFavoriteUseCase
        )
        
        self.personDetailViewModel = PersonDetailViewModel(fetchPersonShowCreditsUseCase: fetchPersonShowCreditsUseCase)
    }
}
