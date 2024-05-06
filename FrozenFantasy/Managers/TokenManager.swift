//
//  TokenManager.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 05.03.2024.
//

import Alamofire
import Foundation
import KeychainSwift

protocol TokenManagerProtocol {
    var tokenPair: TokenPair! { get }
    var authHeader: HTTPHeader { get }

    func save(_ newTokenPair: TokenPair)
    func isTokenValid() -> Bool
    func deleteTokens()
}

final class TokenManager: TokenManagerProtocol {
    static let shared: TokenManagerProtocol = TokenManager()

    var tokenPair: TokenPair!

    var authHeader: HTTPHeader {
        .authorization(bearerToken: tokenPair.accessToken)
    }

    private let keychain = KeychainSwift(keyPrefix: "frozenfantasy_")

    func save(_ newTokenPair: TokenPair) {
        tokenPair = newTokenPair
        guard let data = try? JSONEncoder().encode(newTokenPair)
        else {
            fatalError("Failed to encode Token Pair")
        }
        keychain.set(data, forKey: "tokenPair")
    }

    func isTokenValid() -> Bool {
        if tokenPair == nil {
            restoreTokens()
        }

        if let tokenPair, tokenPair.expirationDate > .now {
            return true
        } else {
            return false
        }
    }

    private func restoreTokens() {
        if let data = keychain.getData("tokenPair"),
           let tokenPair = try? JSONDecoder().decode(TokenPair.self, from: data) {
            self.tokenPair = tokenPair
        }
    }

    private func refreshTokens() {
        Task {
            do {
                let newTokenPair = try await NetworkManager.shared.request(
                    endpoint: AuthAPI.refreshTokens(
                        refreshToken: tokenPair.refreshToken
                    )
                ).data(as: TokenPair.self)
                save(newTokenPair)
            } catch {
                deleteTokens()
                fatalError()
            }
        }
    }

    func deleteTokens() {
        tokenPair = nil
        keychain.delete("tokenPair")
    }
}
