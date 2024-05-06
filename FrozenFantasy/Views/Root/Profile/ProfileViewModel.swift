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

    func fetchUserInfo() async {
        await MainActor.run {
            user = .dummy
        }
    }

    func fetchTransactions() async {
        await MainActor.run {
            transactions = .dummy
        }
    }

    func logout() {}
}
