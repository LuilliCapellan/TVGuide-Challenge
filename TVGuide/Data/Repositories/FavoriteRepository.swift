//
//  FavoriteRepository.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

protocol FavoriteRepository {
    func addFavorite(_ tvShow: TVShow)
    func removeFavorite(tvShowId: Int)
    func fetchFavorites() -> [FavoriteTVShow]
    func searchFavorites(query: String) -> [FavoriteTVShow]
    func isFavorite(tvShowId: Int) -> Bool
}
