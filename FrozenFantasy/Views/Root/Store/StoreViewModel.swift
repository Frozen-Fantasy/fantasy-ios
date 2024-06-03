//
//  StoreViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.06.2024.
//

import Foundation

final class StoreViewModel: ObservableObject {
    @MainActor @Published var cardPacks: [CollectionCardPack] = []
    @MainActor @Published var presentingSuccess: Bool = false

    func fetchCardPacks() async {
        do {
            let data = try await NetworkManager.shared.request(
                from: StoreAPI.getProducts,
                expecting: [CollectionCardPack].self)
            await MainActor.run {
                cardPacks = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }

    func buyCardPack(id: Int) async {
        do {
            try await NetworkManager.shared.request(
                from: StoreAPI.buyProduct(id: id))
            await MainActor.run {
                presentingSuccess = true
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
