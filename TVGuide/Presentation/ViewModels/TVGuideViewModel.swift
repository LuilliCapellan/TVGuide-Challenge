//
//  TVGuideViewModel.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Combine
import Foundation

final class TVGuideViewModel: ObservableObject {
    @Published var tvShows: [TVShow] = []
    @Published var searchResults: [TVShow] = []
    @Published var isLoading = false
    @Published var currentPage = 0
    @Published var searchQuery: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let fetchTVShowsUseCase: FetchTVShowsUseCaseProtocol
    private let searchTVShowsUseCase: SearchTVShowsUseCaseProtocol
    
    init(fetchTVShowsUseCase: FetchTVShowsUseCaseProtocol, searchTVShowsUseCase: SearchTVShowsUseCaseProtocol) {
        self.fetchTVShowsUseCase = fetchTVShowsUseCase
        self.searchTVShowsUseCase = searchTVShowsUseCase
        setupSearchListener()
    }
    
    func fetchTVShows() async {
        guard !isLoading else { return }
        
        await MainActor.run {
            isLoading = true
        }
        print("🔄 Fetching TV shows for page \(currentPage)...")
        
        do {
            let shows = try await fetchTVShowsUseCase.execute(page: currentPage)
            
            await MainActor.run {
                let previousCount = self.tvShows.count
                self.tvShows.append(contentsOf: shows)
                self.currentPage += 1
                self.isLoading = false
                print("📦 Received \(shows.count) TV shows.")
                print("📢 Before: \(previousCount) shows, After: \(self.tvShows.count) shows")
            }
        } catch {
            await MainActor.run {
                self.isLoading = false
                print("❌ API Error: \(error)")
            }
        }
    }
    
    private func setupSearchListener() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self = self else { return }
                if newValue.isEmpty {
                    self.searchResults = []
                } else {
                    Task {
                        await self.performSearch(query: newValue)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func performSearch(query: String) async {
        guard !query.isEmpty else {
            await MainActor.run {
                self.searchResults = []
            }
            return
        }
        
        do {
            let results = try await searchTVShowsUseCase.execute(query: searchQuery)
            await MainActor.run {
                self.searchResults = results
                print("🔍 Found \(results.count) search results.")
            }
        } catch {
            print("❌ Error searching TV shows: \(error)")
        }
    }
}
