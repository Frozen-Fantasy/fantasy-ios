//
//  RegistrationViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Foundation

final class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var code: String = ""

    @Published var nickname: String = ""
    @Published var password: String = ""

    @Published var isEmailValid: Bool = false
    @Published var isCodeValid: Bool = false
    @Published var isNicknameValid: Bool = false
    @Published var isPasswordValid: Bool = false

    @MainActor @Published var errorMessage: String = ""

    var isValid: Bool {
        isEmailValid && isCodeValid && isNicknameValid && isPasswordValid
    }

    func sendCode() async {
        do {
            try await NetworkManager.shared.request(
                from: AuthAPI.sendEmail(email: email)
            )
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }

    func register() async {
        do {
            try await NetworkManager.shared.request(
                from: AuthAPI.signUp(
                    code: Int(code)!,
                    email: email,
                    nickname: nickname,
                    password: password
                )
            )

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

    func routeToLogin() async {
        await AppState.shared.setCurrentScreen(to: .login)
    }
}
