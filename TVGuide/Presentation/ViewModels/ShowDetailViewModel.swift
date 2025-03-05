//
//  ShowDetailViewModel.swift
//  TVGuide
//
//  Created by Luis Capellan on 3/3/25.
//

import Foundation

final class ShowDetailViewModel: ObservableObject {
    @Published var show: TVShow?
    @Published var episodesBySeason: [Int: [Episode]] = [:]
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let fetchShowDetailsUseCase: FetchShowDetailsUseCaseProtocol
    private let fetchShowEpisodesUseCase: FetchShowEpisodesUseCaseProtocol

    init(
        fetchShowDetailsUseCase: FetchShowDetailsUseCaseProtocol,
        fetchShowEpisodesUseCase: FetchShowEpisodesUseCaseProtocol
    ) {
        self.fetchShowDetailsUseCase = fetchShowDetailsUseCase
        self.fetchShowEpisodesUseCase = fetchShowEpisodesUseCase
    }

    func loadShowDetails(showId: Int) async {
        guard !isLoading else { return }
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }

        do {
            let show = try await fetchShowDetailsUseCase.execute(showId: showId)
            await MainActor.run { self.show = show }

            // Now fetch episodes separately
            do {
                let episodes = try await fetchShowEpisodesUseCase.execute(showId: showId)
                await MainActor.run {
                    self.episodesBySeason = Dictionary(grouping: episodes, by: { $0.season })
                }
            } catch {
                await MainActor.run { self.errorMessage = error.localizedDescription }
            }
        } catch {
            await MainActor.run { self.errorMessage = error.localizedDescription }
        }

        await MainActor.run {
            isLoading = false
        }
    }
}
