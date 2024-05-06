//
//  RegistrationViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Foundation

@MainActor final class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var code: String = ""

    @Published var nickname: String = ""
    @Published var password: String = ""

    @Published var isEmailValid: Bool = false
    @Published var isCodeValid: Bool = false
    @Published var isNicknameValid: Bool = false
    @Published var isPasswordValid: Bool = false

    var isValid: Bool {
        isEmailValid && isCodeValid && isNicknameValid && isPasswordValid
    }

    @Published var errorMessage: String = ""

    @Published var alertMessage: String = ""
    @Published var presentingAlert: Bool = false

    func sendCode() async {
        do {
            _ = try await NetworkManager.shared.request(
                endpoint: AuthAPI.sendEmail(email: email)
            ).data()
        } catch {
            alertMessage = error.localizedDescription
            presentingAlert = true
        }
    }

    func register() async -> Bool {
        do {
            _ = try await NetworkManager.shared.request(
                endpoint: AuthAPI.signUp(
                    code: Int(code)!,
                    email: email,
                    nickname: nickname,
                    password: password
                )
            ).data()

            let tokenPair = try await NetworkManager.shared.request(
                endpoint: AuthAPI.signIn(
                    email: email,
                    password: password
                )
            ).data(as: TokenPair.self)
            TokenManager.shared.save(tokenPair)

            return true
        } catch APIError.badRequest {
            errorMessage = "Неверный код верификации"
            return false
        } catch {
            alertMessage = error.localizedDescription
            presentingAlert = true
            return false
        }
    }
}
