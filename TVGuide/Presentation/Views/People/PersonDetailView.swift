//
//  PersonDetailView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/4/25.
//

import SwiftUI

struct PersonDetailView: View {
    @Environment(\.viewModels.personDetailViewModel) private var viewModel

    var person: Person
    @State private var shows: [TVShow] = []
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                VStack(spacing: 16) {
                    PersonImageView(imageURL: person.image?.original)
                    
                    // Show Name
                    Text(person.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Genres
                    if let country = person.country?.name {
                        Text("Nationality: \(country)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Show list
                    TVShowListView(tvShows: shows) { }
                }
                .padding()
            }
        }
        .onAppear {
            setupUI()
        }
        .onReceive(viewModel.$tvShowCredits, perform: { shows in
            self.shows = shows
        })
        .onReceive(viewModel.$isLoading, perform: { isLoading in
            self.isLoading = isLoading
        })
        .navigationTitle(person.name)
    }
}

//MARK: -Functions
extension PersonDetailView {
    private func setupUI() {
        shows = []
        Task {
            await viewModel.fetchPersonShowCredits(personId: person.id)
        }
    }
}
