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

    @Published var username: String = ""
    @Published var password: String = ""

    @Published var isEmailValid: Bool = false
    @Published var isCodeValid: Bool = false
    @Published var isUsernameValid: Bool = false
    @Published var isPasswordValid: Bool = false

    var isValid: Bool {
        isEmailValid && isCodeValid && isUsernameValid && isPasswordValid
    }

    @Published var errorMessage: String = ""

    @Published var alertMessage: String = ""
    @Published var presentingAlert: Bool = false

    func sendCode() async {
        do {
            let _ = try await NetworkManager.shared.request(
                endpoint: AuthAPI.sendEmail(email: email)
            ).data()
        } catch {
            alertMessage = error.localizedDescription
            presentingAlert = true
        }
    }

    func register() async -> Bool {
        do {
            let _ = try await NetworkManager.shared.request(
                endpoint: AuthAPI.signUp(
                    code: Int(code)!,
                    email: email,
                    username: username,
                    password: password
                )
            ).data()

            let _ = try await NetworkManager.shared.request(
                endpoint: AuthAPI.signIn(
                    email: email,
                    password: password
                )
            ).data(as: TokenPair.self)

            return true
        } catch APIError.badRequest {
            return false
        } catch {
            alertMessage = error.localizedDescription
            presentingAlert = true
            return false
        }
    }
}
