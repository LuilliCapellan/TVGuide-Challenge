//
//  TVGuideView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

struct TVGuideView: View {
    @Environment(\.viewModels.tvGuideViewModel) private var viewModel
    @State private var tvList: [TVShow] = []
    @State private var searchQuery: String = ""
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        VStack {
            SearchBarView(searchQuery: $searchQuery, isFocused: $isSearchFocused)
            
            TVShowListView(tvShows: tvList, onScrolledToEnd: {
                if searchQuery.isEmpty {
                    Task {
                        await viewModel.fetchTVShows()
                    }
                }
            })
            .onReceive(viewModel.$tvShows) { newValue in
                if searchQuery.isEmpty {
                    tvList = newValue
                }
            }
            .onReceive(viewModel.$searchResults) { newValue in
                if !searchQuery.isEmpty {
                    tvList = newValue
                }
            }
            .onChange(of: searchQuery) { _, newValue in
                if newValue.isEmpty {
                    tvList = viewModel.tvShows
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .onChange(of: searchQuery) { _, newValue in
            viewModel.searchQuery = newValue
        }
        .onAppear {
            searchQuery = viewModel.searchQuery
            if tvList.isEmpty {
                Task {
                    await viewModel.fetchTVShows()
                    DispatchQueue.main.async {
                        tvList = viewModel.tvShows
                    }
                }
            }
        }
    }
}
