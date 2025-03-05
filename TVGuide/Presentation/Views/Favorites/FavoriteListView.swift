//
//  FavoriteListView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

struct FavoriteListView: View {
    let tvShows: [FavoriteTVShow]
    
    var body: some View {
        List {
            ForEach(tvShows) { show in
                NavigationLink {
                    ShowDetailView(showId: show.id)
                } label: {
                    HStack(spacing: 12) {
                        TVShowImageView(imageString: show.imageURLMedium)
                        VStack(alignment: .leading) {
                            Text(show.name)
                                .font(.headline)
                            
                            Text(show.summary ?? "No summary")
                                .font(.subheadline)
                                .lineLimit(5)
                            
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }
}
