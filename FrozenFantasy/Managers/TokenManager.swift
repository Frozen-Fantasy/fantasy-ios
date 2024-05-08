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
    var isTokenValid: Bool { get }

    func save(_ newTokenPair: TokenPair)
    func deleteTokens()
}

final class TokenManager: TokenManagerProtocol {
    static let shared: TokenManagerProtocol = TokenManager()

    private let keychain = KeychainSwift(keyPrefix: "frozenfantasy_")
    private let networkManager = NetworkManager.shared

    var tokenPair: TokenPair!
    var authHeader: HTTPHeader {
        .authorization(bearerToken: tokenPair.accessToken)
    }

    let tokenKey = "tokens"

    func save(_ newTokenPair: TokenPair) {
        tokenPair = newTokenPair
        guard let data = try? JSONEncoder().encode(newTokenPair)
        else { fatalError("Failed to encode tokens") }

        keychain.set(data, forKey: tokenKey)
    }

    lazy var isTokenValid: Bool = {
        if let data = keychain.getData(tokenKey),
           let tokenPair = try? JSONDecoder().decode(TokenPair.self, from: data) {
            self.tokenPair = tokenPair
        }

        if let tokenPair, tokenPair.expirationDate > .now {
            refreshTokens()
            return true
        } else {
            deleteTokens()
            return false
        }
    }()

    private func refreshTokens() {
        Task {
            do {
                let newTokenPair = try await networkManager.request(
                    from: AuthAPI.refreshTokens(
                        refreshToken: tokenPair.refreshToken
                    ), expecting: TokenPair.self
                )
                save(newTokenPair)
            } catch {
                deleteTokens()
                fatalError("Unable to refresh tokens")
            }
        }
    }

    func deleteTokens() {
        tokenPair = nil
        keychain.delete(tokenKey)
    }
}
