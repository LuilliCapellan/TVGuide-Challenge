//
//  FavoritesView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.viewModels.favoritesViewModel) private var viewModel
    @State private var searchQuery: String = ""
    @State private var favoritesList: [FavoriteTVShow] = []
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        VStack {
            SearchBarView(searchQuery: $searchQuery, isFocused: $isSearchFocused)
            
            FavoriteListView(
                tvShows: favoritesList
            )
            .onReceive(viewModel.$favorites) { newValue in
                if searchQuery.isEmpty {
                    favoritesList = newValue
                }
            }
            .onReceive(viewModel.$searchResults) { newValue in
                if !searchQuery.isEmpty {
                    favoritesList = newValue
                }
            }
            .onChange(of: searchQuery) { _, newValue in
                if newValue.isEmpty {
                    favoritesList = viewModel.favorites
                }
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                viewModel.fetchFavorites()
            }
        }
    }
}
