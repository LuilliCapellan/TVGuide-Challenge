//
//  ShowDetailView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

struct ShowDetailView: View {
    @Environment(\.viewModels.showDetailViewModel) var viewModel
    @Environment(\.viewModels.favoritesViewModel) var favoriteViewModel
    let showId: Int
    
    @State private var show: TVShow?
    @State private var episodesBySeason: [Int: [Episode]] = [:]
    @State private var isLoading = false
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView()
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    TVShowDetailImageView(imageURL: show?.image?.original)
                    
                    // Show Name
                    Text(show?.name ?? "No Title")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Air Schedule
                    if let schedule = show?.schedule {
                        Text("Airs: \(schedule.days.joined(separator: ", ")) at \(schedule.time)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Genres
                    if let genres = show?.genres, !genres.isEmpty {
                        Text("Genres: \(genres.joined(separator: ", "))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Show Summary
                    Text(show?.summary?.removingHTMLTags() ?? "No summary available")
                        .font(.body)
                    
                    // Casting
                    if let cast = show?.embedded?.cast, !cast.isEmpty {
                        
                        Text("Casting")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        CastListView(cast: cast)
                    }
                    
                    // Episodes Section
                    if !episodesBySeason.isEmpty {
                        SeasonListView(episodesBySeason: episodesBySeason)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            setupUI()
        }
        .onReceive(viewModel.$show, perform: { show in
            self.show = show
        })
        .onReceive(viewModel.$episodesBySeason, perform: { episodes in
            self.episodesBySeason = episodes
        })
        .onReceive(viewModel.$isLoading, perform: { isLoading in
            self.isLoading = isLoading
        })
        .navigationTitle(viewModel.show?.name ?? "Show Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                }
            }
        }
    }
}

//MARK: -Functions
extension ShowDetailView {
    private func setupUI() {
        show = nil
        episodesBySeason = [:]
        Task {
            await viewModel.loadShowDetails(showId: showId)
        }
        checkIfFavorite()
    }
    
    private func checkIfFavorite()  {
        isFavorite = favoriteViewModel.isFavorite(showId: showId)
    }
    
    private func toggleFavorite() {
        if isFavorite {
            favoriteViewModel.removeFavorite(tvShowId: showId)
        } else {
            favoriteViewModel.addFavorite(tvShow: show!)
        }
        isFavorite.toggle() // Update UI instantly
    }
}
