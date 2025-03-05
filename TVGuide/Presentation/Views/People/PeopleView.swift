//
//  PeopleView.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import SwiftUI

struct PeopleView: View {
    @Environment(\.viewModels.peopleViewModel) private var viewModel
    @State private var peopleList: [Person] = []
    @State private var searchQuery: String = ""
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        VStack {
            SearchBarView(searchQuery: $searchQuery, isFocused: $isSearchFocused)

            List {
                ForEach(peopleList) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    } label: {
                        HStack {
                            PeopleImageView(imageURL: person.image?.medium)

                            VStack(alignment: .leading) {
                                Text(person.name)
                                    .font(.headline)
                                if let country = person.country?.name {
                                    Text(country)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .onAppear {
                            if searchQuery.isEmpty {
                                if person == peopleList.last {
                                    Task {
                                        await viewModel.fetchPeople()
                                    }
                                }
                            }
                        }
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if peopleList.isEmpty && !searchQuery.isEmpty {
                    Text("No results found")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .onReceive(viewModel.$people) { newValue in
                if searchQuery.isEmpty {
                    peopleList = newValue
                }
            }
            .onReceive(viewModel.$searchResults) { newValue in
                if !searchQuery.isEmpty {
                    peopleList = newValue
                }
            }
            .onChange(of: searchQuery) { _, newValue in
                viewModel.searchQuery = newValue
                if newValue.isEmpty {
                    peopleList = viewModel.people
                }
            }
        }
        .onAppear {
            searchQuery = viewModel.searchQuery
            if peopleList.isEmpty {
                Task {
                    await viewModel.fetchPeople()
                    DispatchQueue.main.async {
                        peopleList = viewModel.people
                    }
                }
            }
        }
    }
}
