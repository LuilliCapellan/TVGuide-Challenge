//
//  FavoriteTVShow.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import RealmSwift

final class FavoriteTVShow: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var summary: String?
    @Persisted var imageURLMedium: String?
    @Persisted var imageURLOriginal: String?
    
    convenience init(tvShow: TVShow) {
        self.init()
        self.id = tvShow.id
        self.name = tvShow.name
        self.summary = tvShow.summary
        self.imageURLMedium = tvShow.image?.medium?.absoluteString
        self.imageURLOriginal = tvShow.image?.original?.absoluteString
    }
}
