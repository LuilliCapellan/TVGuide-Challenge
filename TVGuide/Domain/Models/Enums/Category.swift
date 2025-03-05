//
//  Category.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

enum Category: String, CaseIterable, Identifiable {
    case tvShows = "TV Shows"
    case people = "People"
    case favorites = "Favorites"
    
    var id: String { self.rawValue }
}
