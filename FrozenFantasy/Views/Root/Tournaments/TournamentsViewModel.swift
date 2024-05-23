//
//  TournamentsViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Foundation

@MainActor final class TournamentsViewModel: ObservableObject {
    @Published var tournaments: Tournaments = []

    @Published var alertMessage: String = ""
    @Published var presentingAlert: Bool = false

    func getTournaments() async {
        do {
            tournaments = try await NetworkManager.shared.request(
                from: TournamentsAPI.getTournaments(showAll: true, tournamentID: nil, league: nil, status: nil),
                expecting: Tournaments.self
            ).sorted { $0.startDate > $1.startDate }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
