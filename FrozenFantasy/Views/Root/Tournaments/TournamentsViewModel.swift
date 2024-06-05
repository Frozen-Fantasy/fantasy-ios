//
//  TournamentsViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Foundation

final class TournamentsViewModel: ObservableObject {
    @MainActor @Published var tournaments: Tournaments = []

    @MainActor var activeTournaments: [Tournament] {
        tournaments.filter { $0.status != .finished}
    }

    @MainActor var personalPastTournaments: [Tournament] {
        tournaments.filter { $0.participating && $0.status == .finished }
    }

    @MainActor var allPastTournaments: [Tournament] {
        tournaments.filter { $0.status == .finished }
    }

    func getTournaments() async {
        do {
            let data = try await NetworkManager.shared.request(
                from: TournamentsAPI.getTournaments(showAll: true, tournamentID: nil, league: nil, status: nil),
                expecting: Tournaments.self
            ).sorted { $0.startDate > $1.startDate }
            await MainActor.run {
                tournaments = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
