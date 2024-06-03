//
//  StoreViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.06.2024.
//

import Foundation

final class StoreViewModel: ObservableObject {
    @MainActor @Published var cardPacks: [CollectionCardPack] = []

    func fetchCardPacks() async {
        await MainActor.run {
            cardPacks = [.dummy]
        }
    }
}
