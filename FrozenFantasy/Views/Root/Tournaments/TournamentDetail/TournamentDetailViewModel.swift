//
//  TournamentDetailViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

final class TournamentDetailViewModel: ObservableObject {
    @MainActor @Published var matches: Matches = []

    var tournamentID: Int = 0

    func fetchMatches() async {
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
