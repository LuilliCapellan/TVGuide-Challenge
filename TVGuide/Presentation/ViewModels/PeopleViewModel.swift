//
//  PeopleViewModel.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation
import Combine

final class PeopleViewModel: ObservableObject {
    @Published var people: [Person] = []
    @Published var searchResults: [Person] = []
    @Published var isLoading = false
    @Published var searchQuery: String = ""
    @Published var currentPage = 0
    
    private var cancellables = Set<AnyCancellable>()
    private let fetchPeopleUseCase: FetchPeopleUseCaseProtocol
    
    init(fetchPeopleUseCase: FetchPeopleUseCaseProtocol) {
        self.fetchPeopleUseCase = fetchPeopleUseCase
        setupSearchListener()
    }
    
    func fetchPeople() async {
        guard !isLoading else { return }
        isLoading = true
        
        do {
            let newPeople = try await fetchPeopleUseCase.execute(page: currentPage)
            people.append(contentsOf: newPeople)
            currentPage += 1
        } catch {
            print("❌ Error fetching people: \(error)")
        }
        
        isLoading = false
    }
    
    private func performSearch(query: String) async {
        guard !query.isEmpty else {
            await MainActor.run {
                searchResults = []
            }
            return
        }
        
        do {
            let results = try await fetchPeopleUseCase.search(query: query)
            await MainActor.run {
                self.searchResults = results
            }
        } catch {
            print("❌ Error searching people: \(error)")
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
}
