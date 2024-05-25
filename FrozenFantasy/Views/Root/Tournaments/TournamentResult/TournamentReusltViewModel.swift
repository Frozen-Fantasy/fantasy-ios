//
//  TournamentReusltViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 25.05.2024.
//

import Foundation

final class TournamentReusltViewModel: ObservableObject {
    @Published var result: TournamentResult?

    @MainActor var tournament: Tournament?

    func fetchResult() async {
        guard let tournamentID = await tournament?.id else { return }
        do {
            let data = try await NetworkManager.shared.request(
                from: TournamentsAPI.getTournamentResult(tournamentID: tournamentID),
                expecting: TournamentResult.self)
            await MainActor.run {
                result = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
