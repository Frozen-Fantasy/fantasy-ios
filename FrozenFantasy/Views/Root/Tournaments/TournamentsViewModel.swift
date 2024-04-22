//
//  TournamentsViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Foundation

@MainActor final class TournamentsViewModel: ObservableObject {
    @Published var tournaments: [Tournament] = []

    @Published var alertMessage: String = ""
    @Published var presentingAlert: Bool = false

    func getTournaments() async {
        do {
            tournaments = try await NetworkManager.shared.request(
                endpoint: TournamentsAPI.getTournaments(
                    league: .Both)
            ).data(as: [Tournament].self)
        } catch {
            alertMessage = error.localizedDescription
            presentingAlert = true
        }
    }
}
