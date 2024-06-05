//
//  UserStore.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 06.06.2024.
//

import Foundation

final class UserStore: ObservableObject {
    @Published @MainActor var user: User?

    func fetchUserInfo() async {
        do {
            let data = try await NetworkManager.shared.request(
                from: UserAPI.info,
                expecting: User.self
            )
            await MainActor.run {
                user = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
