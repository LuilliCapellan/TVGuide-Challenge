//
//  SeasonListView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/5/25.
//

import SwiftUI

struct SeasonListView: View {
    @State private var selectedSeason: Int = 1
    let episodesBySeason: [Int: [Episode]]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Custom Picker Button
            Menu {
                ForEach(episodesBySeason.keys.sorted(), id: \.self) { season in
                    Button(action: {
                        DispatchQueue.main.async {
                            selectedSeason = season
                        }
                    }) {
                        Text("Season \(season)")
                            .font(.title3)
                    }
                }
            } label: {
                HStack {
                    Text("Season \(selectedSeason)")
                        .font(.title)
                        .foregroundColor(.primary)
                    Image(systemName: "chevron.down")
                        .font(.title3)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
            }
            .padding(.horizontal)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if let episodes = episodesBySeason[selectedSeason], !episodes.isEmpty {
                        ForEach(episodes) { episode in
                            NavigationLink(destination: EpisodeDetailView(episode: episode)) {
                                HStack {
                                    VStack {
                                        
                                        EpisodeImageView(imageURL: episode.image?.medium)
                                        
                                        if let rating = episode.rating?.average {
                                            HStack(alignment: .firstTextBaseline) {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.yellow)
                                                Text(String(format: "%.1f", rating))
                                            }
                                            .font(.subheadline)
                                            .padding(.horizontal, 2)
                                        }
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(episode.name)
                                                .font(.headline)
                                            
                                            Text("Episode \(episode.number)")
                                                .font(.caption)
                                        }
                                        
                                        Text(episode.summary?.removingHTMLTags() ?? "No summary available")
                                            .lineLimit(4)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.vertical, 5)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    } else {
                        Text("No episodes available for Season \(selectedSeason)")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            if let firstSeason = episodesBySeason.keys.sorted().first {
                selectedSeason = firstSeason
            }
        }
    }
}
