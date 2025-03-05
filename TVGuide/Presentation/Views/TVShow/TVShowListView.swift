//
//  TVShowListView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//
import SwiftUI

struct TVShowListView: View {
    let tvShows: [TVShow]
    let onScrolledToEnd: () -> Void
    
    var body: some View {
        List {
            ForEach(tvShows) { show in
                NavigationLink {
                    ShowDetailView(showId: show.id)
                } label: {
                    HStack(spacing: 12) {
                        TVShowImageView(imageURL: show.image?.medium)
                        VStack(alignment: .leading) {
                            Text(show.name)
                                .font(.headline)
                            
                            Text(show.summary?.removingHTMLTags() ?? "No summary available")
                                .font(.subheadline)
                                .lineLimit(5)
                        }
                    }
                    .padding(.vertical, 5)
                    .onAppear {
                        if show == tvShows.last {
                            onScrolledToEnd()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TVShowListView(tvShows: [
        TVShow(
            id: 1,
            name: "Breaking Bad",
            schedule: TVShow.Schedule(time: "21:00", days: ["Sunday"]),
            summary: "A high school chemistry teacher turned methamphetamine producer.",
            image: TVShow.ImageURLs(medium: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg"), original: nil),
            genres: ["Crime", "Drama", "Thriller"],
            embedded: nil
        ),
        TVShow(
            id: 2,
            name: "Stranger Things",
            schedule: TVShow.Schedule(time: "22:00", days: ["Friday"]),
            summary: "A group of kids uncover supernatural mysteries in their town.",
            image: TVShow.ImageURLs(medium: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/200/501942.jpg"), original: nil),
            genres: ["Drama", "Fantasy", "Horror"],
            embedded: nil
        ),
        TVShow(
            id: 3,
            name: "Game of Thrones",
            schedule: nil,
            summary: "Noble families vie for control of the Iron Throne.",
            image: nil,
            genres: [],
            embedded: nil
        )
    ], onScrolledToEnd: {})
}
