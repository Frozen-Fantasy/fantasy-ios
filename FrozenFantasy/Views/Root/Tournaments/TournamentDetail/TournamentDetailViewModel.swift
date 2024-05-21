//
//  TournamentDetailViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

@MainActor final class TournamentDetailViewModel: ObservableObject {
    @Published var matches: Matches = []

    var tournamentID: Int = 0

    func fetchMatches() {
        Task {
            do {
                let data: Matches = [.dummy, .dummy, .dummy]
                await MainActor.run {
                    matches = data
                }
            } catch {
                await AppState.shared.presentAlert(message: error.localizedDescription)
            }
        }
    }
}
