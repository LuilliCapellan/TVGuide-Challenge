//
//  EpisodeDetailView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

struct EpisodeDetailView: View {
    let episode: Episode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Episode Image
                EpisodeDetailImageView(imageURL: episode.image?.original)
                
                HStack {
                    // Episode Title
                    Text(episode.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // Episode Rating
                    if let rating = episode.rating?.average {
                        HStack() {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", rating))
                        }
                        .font(.subheadline)
                    }
                }
                
                // Season and Episode Number
                Text("Season \(episode.season), Episode \(episode.number)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                // Air Date
                if let airdate = episode.airdate {
                    Text("Aired on: \(airdate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
                
                // Episode Summary
                Text(episode.summary?.removingHTMLTags() ?? "No summary available")
                    .font(.body)
                    .padding()
                
                Spacer()
            }
            .padding(.top)
        }
        .navigationTitle(episode.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
