//
//  ProfileViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 06.05.2024.
//

import Foundation

@MainActor final class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var transactions: Transactions?

    @Published var presentingLogoutAlert = false

    func fetchUserInfo() async {
        do {
            user = try await NetworkManager.shared.request(
                from: UserAPI.info,
                expecting: User.self
            )
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }

    func fetchTransactions() async {
        do {
            transactions = try await NetworkManager.shared.request(
                from: UserAPI.transactions,
                expecting: Transactions.self
            )
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }

    func logout() async {
        do {
            let refreshToken = TokenManager.shared.tokenPair.refreshToken
            TokenManager.shared.deleteTokens()

            try await NetworkManager.shared.request(
                from: AuthAPI.logout(refreshToken: refreshToken)
            )

            await AppState.shared.setCurrentScreen(to: .login)
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
