//
//  CollectionViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 08.05.2024.
//

import Foundation

final class CollectionViewModel: ObservableObject {
    @MainActor @Published var cards: [CollectionCard] = []
    @MainActor @Published var coins: Int = 0

    func fetchCards() async {
        do {
            let user = try await NetworkManager.shared.request(
                from: UserAPI.info,
                expecting: User.self)
            let data = try await NetworkManager.shared.request(
                from: PlayersAPI.playerCards(profileID: user.id,
                                             rarity: nil,
                                             league: nil,
                                             unpacked: nil),
                expecting: [CollectionCard].self)
            await MainActor.run {
                cards = data
                coins = user.coins
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
