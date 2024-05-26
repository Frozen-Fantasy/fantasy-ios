//
//  TournamentResultViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 25.05.2024.
//

import Foundation

final class TournamentResultViewModel: ObservableObject {
    @Published var matches: Matches = []
    @Published var results: [TournamentResult] = []

    @MainActor var tournament: Tournament?

    func fetchResult() async {
        guard let tournamentID = await tournament?.id else { return }
        do {
            let data = try await NetworkManager.shared.request(
                from: TournamentsAPI.getTournamentResult(tournamentID: tournamentID),
                expecting: [TournamentResult].self)
            await MainActor.run {
                results = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }

    func fetchMatches() async {
        guard let tournamentID = await tournament?.id else { return }
        do {
            let data: Matches = try await NetworkManager.shared.request(
                from: TournamentsAPI.getMatches(tournamentID: tournamentID),
                expecting: Matches.self)
            await MainActor.run {
                matches = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
