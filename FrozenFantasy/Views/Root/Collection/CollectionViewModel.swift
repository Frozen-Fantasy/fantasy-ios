//
//  CollectionViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 08.05.2024.
//

import Foundation

final class CollectionViewModel: ObservableObject {
    @MainActor @Published var cards: [CollectionCard] = []

    func fetchCards(userID: UUID?) async {
        guard let userID else { return }
        do {
            let data = try await NetworkManager.shared.request(
                from: PlayersAPI.getPlayerCards(profileID: userID,
                                                rarity: nil,
                                                league: nil,
                                                unpacked: nil),
                expecting: [CollectionCard].self)
            await MainActor.run {
                cards = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }

    func unpackCard(id: Int) async {
        do {
            try await NetworkManager.shared.request(
                from: PlayersAPI.unpackCard(id: id))
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
