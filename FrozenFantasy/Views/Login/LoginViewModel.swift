//
//  LoginViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 21.04.2024.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false

    @MainActor @Published var errorMessage: String = ""

    var isValid: Bool {
        isEmailValid && isPasswordValid
    }

    func login() async {
        do {
            let tokenPair = try await NetworkManager.shared.request(
                from: AuthAPI.signIn(
                    email: email,
                    password: password
                ),
                expecting: TokenPair.self
            )

            TokenManager.shared.save(tokenPair)
            await AppState.shared.setCurrentScreen(to: .main)
        } catch let APIError.badRequest(reason) {
            await MainActor.run {
                errorMessage = reason
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }

    func routeToRegistration() async {
        await AppState.shared.setCurrentScreen(to: .registration)
    }
}
