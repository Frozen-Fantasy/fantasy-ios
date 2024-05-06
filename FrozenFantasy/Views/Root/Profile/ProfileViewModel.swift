//
//  ProfileViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 06.05.2024.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var user: User = .init()
    @Published var transactions: Transactions = []
    
    @Published var presentingLogoutAlert = false

    @Published var alertMessage: String = ""
    @Published var presentingAlert: Bool = false

    func fetchUserInfo() async {
        do {
            let data = try await NetworkManager.shared.request(
                endpoint: UserAPI.info
            ).data(as: User.self)
            await MainActor.run {
                self.user = data
            }
        } catch {
            await MainActor.run {
                alertMessage = error.localizedDescription
                presentingAlert = true
            }
        }
    }

    func fetchTransactions() async {
        do {
            let data = try await NetworkManager.shared.request(
                endpoint: UserAPI.transactions
            ).data(as: Transactions.self)
            await MainActor.run {
                self.transactions = data
            }
        } catch {
            await MainActor.run {
                alertMessage = error.localizedDescription
                presentingAlert = true
            }
        }
    }

    func logout() {
        let refreshToken = TokenManager.shared.tokenPair.refreshToken
        TokenManager.shared.deleteTokens()
        
        Task {
            try? await NetworkManager.shared.request(
                endpoint: AuthAPI.logout(refreshToken: refreshToken)
            ).data()
        }
    }
}
