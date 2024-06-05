//
//  StatisticsViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.06.2024.
//

import Foundation

final class StatisticsViewModel: ObservableObject {
    @Published @MainActor var players: [Player] = []

    func fetchPlayers() async {
        do {
            let data = try await NetworkManager.shared.request(
                from: PlayersAPI.getPlayers(
                    rarity: nil,
                    league: nil),
                expecting: [Player].self)
            await MainActor.run {
                players = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
