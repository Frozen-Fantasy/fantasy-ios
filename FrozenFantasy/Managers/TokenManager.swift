//
//  TokenManager.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 05.03.2024.
//

import Alamofire
import Foundation
import KeychainSwift

enum TokenManagerError: Error, LocalizedError {
    case noTokens

    var errorDescription: String? {
        switch self {
        case .noTokens:
            "Проблемы "
        }
    }
}

protocol TokenManagerProtocol {
    var tokenPair: TokenPair? { get }
    var authHeader: HTTPHeader { get throws }
    var hasValidToken: Bool { get }

    func saveTokens(_ newTokenPair: TokenPair)
    func deleteTokens()
}

final class TokenManager: TokenManagerProtocol {
    static let shared: TokenManagerProtocol = TokenManager()

    private let keychain = KeychainSwift(keyPrefix: "frozenfantasy_")
    private let keychainKey = "tokens"
    private let networkManager = NetworkManager.shared

    var tokenPair: TokenPair?
    var authHeader: HTTPHeader {
        get throws {
            guard let tokenPair else { throw TokenManagerError.noTokens }
            return .authorization(bearerToken: tokenPair.accessToken)
        }
    }

    lazy var hasValidToken: Bool = {
        if let data = keychain.getData(keychainKey),
           let tokenPair = try? JSONDecoder().decode(TokenPair.self, from: data),
           tokenPair.expirationDate > .now {
            self.tokenPair = tokenPair
            refreshTokens(with: tokenPair.refreshToken)
            return true
        } else {
            deleteTokens()
            return false
        }
    }()

    private func refreshTokens(with refreshToken: String) {
        Task {
            do {
                let newTokenPair = try await networkManager.request(
                    from: AuthAPI.refreshTokens(refreshToken: refreshToken),
                    expecting: TokenPair.self
                )
                saveTokens(newTokenPair)
            } catch {
                deleteTokens()
                fatalError("Unable to refresh tokens")
            }
        }
    }

    func saveTokens(_ newTokenPair: TokenPair) {
        tokenPair = newTokenPair
        guard let data = try? JSONEncoder().encode(newTokenPair)
        else { fatalError("Failed to encode tokens") }

        keychain.set(data, forKey: keychainKey)
    }

    func deleteTokens() {
        tokenPair = nil
        keychain.delete(keychainKey)
    }
}
