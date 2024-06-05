//
//  ProfileViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 06.05.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @MainActor @Published var transactions: Transactions?

    @Published var presentingLogoutAlert = false

    func fetchTransactions() async {
        do {
            let data = try await NetworkManager.shared.request(
                from: UserAPI.transactions,
                expecting: Transactions.self
            )
            await MainActor.run {
                transactions = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }

    func logout() async {
        do {
            guard let refreshToken = TokenManager.shared.tokenPair?.refreshToken
            else { return }

            try await NetworkManager.shared.request(
                from: AuthAPI.logout(refreshToken: refreshToken)
            )
            TokenManager.shared.deleteTokens()

            await AppState.shared.setCurrentScreen(to: .login)
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
