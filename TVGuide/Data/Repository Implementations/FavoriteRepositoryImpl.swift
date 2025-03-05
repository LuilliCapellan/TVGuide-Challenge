//
//  FavoriteRepositoryImpl.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import RealmSwift

class FavoriteRepositoryImpl: FavoriteRepository {
    
    private var localRealm: Realm? {
        get {
            return try? Realm()
        }
    }
    
    func addFavorite(_ tvShow: TVShow) {
        try? localRealm?.write({
            let favorite = FavoriteTVShow(tvShow: tvShow)
            localRealm?.add(favorite)
        })
    }
    
    func removeFavorite(tvShowId: Int) {
        if let objectToDelete = localRealm?.object(ofType: FavoriteTVShow.self, forPrimaryKey: tvShowId) {
            try? localRealm?.write {
                localRealm?.delete(objectToDelete)
            }
        }
    }
    
    func fetchFavorites() -> [FavoriteTVShow] {
        let results = localRealm?.objects(FavoriteTVShow.self)
            .sorted(byKeyPath: "name", ascending: true)
        if let results {
            return Array(results)
        } else {
            return []
        }
    }
    
    func searchFavorites(query: String) -> [FavoriteTVShow] {
        let results = localRealm?.objects(FavoriteTVShow.self)
            .filter("name CONTAINS[c] %@", query)
            .sorted(byKeyPath: "name", ascending: true)
        if let results {
            return Array(results)
        } else {
            return []
        }
    }
    
    func isFavorite(tvShowId: Int) -> Bool {
        let realm = try? Realm()
        return realm?.object(ofType: FavoriteTVShow.self, forPrimaryKey: tvShowId) != nil
    }
}
