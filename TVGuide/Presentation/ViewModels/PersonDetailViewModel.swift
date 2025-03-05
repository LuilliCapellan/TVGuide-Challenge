//
//  PersonDetailViewModel.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/4/25.
//

import Foundation

final class PersonDetailViewModel: ObservableObject {
    private let fetchPersonShowCreditsUseCase: FetchPersonShowCreditsUseCaseProtocol

    @Published var tvShowCredits: [TVShow] = []
    @Published var isLoading = false

    init(fetchPersonShowCreditsUseCase: FetchPersonShowCreditsUseCaseProtocol) {
        self.fetchPersonShowCreditsUseCase = fetchPersonShowCreditsUseCase
    }

    func fetchPersonShowCredits(personId: Int) async {
        guard !isLoading else { return }
        await MainActor.run {
            isLoading = true
        }

        do {
            let shows = try await fetchPersonShowCreditsUseCase.execute(personId: personId)
            await MainActor.run {
                self.tvShowCredits = shows
                self.isLoading = false
            }
        } catch {
            print("❌ Error fetching show credits: \(error)")
            await MainActor.run { self.isLoading = false }
        }
    }
}
