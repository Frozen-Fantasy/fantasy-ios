//
//  CollectionViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 08.05.2024.
//

import Foundation

final class CollectionViewModel: ObservableObject {
    @MainActor @Published var cards: Cards = []

    func fetchCards() async {
        do {
            async let userID = NetworkManager.shared.request(
                from: UserAPI.info,
                expecting: User.self).id
            let data = try await NetworkManager.shared.request(
                from: PlayersAPI.playerCards(profileID: await userID,
                                             rarity: nil,
                                             league: nil,
                                             unpacked: nil),
                expecting: Cards.self)
            await MainActor.run {
                cards = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
