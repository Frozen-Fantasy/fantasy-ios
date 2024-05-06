//
//  LoginViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 21.04.2024.
//

import Foundation

@MainActor final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false

    var isValid: Bool {
        isEmailValid && isPasswordValid
    }

    @Published var errorMessage: String = ""

    @Published var alertMessage: String = ""
    @Published var presentingAlert: Bool = false

    func login() async -> Bool {
        do {
            let tokenPair = try await NetworkManager.shared.request(
                endpoint: AuthAPI.signIn(
                    email: email,
                    password: password
                )
            ).data(as: TokenPair.self)
            TokenManager.shared.save(tokenPair)

            return true
        } catch APIError.badRequest {
            errorMessage = "Неправильный логин/пароль"
            return false
        } catch {
            alertMessage = error.localizedDescription
            presentingAlert = true
            return false
        }
    }
}
