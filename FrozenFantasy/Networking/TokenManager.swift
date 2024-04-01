//
//  TokenManager.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 05.03.2024.
//

import Foundation

protocol TokenManagerProtocol {
    static var shared: TokenManagerProtocol { get }

    var accessToken: String { get }
    var refreshToken: String { get }
}

class TokenManager: TokenManagerProtocol {
    static let shared: TokenManagerProtocol = TokenManager()

    var accessToken: String
    var refreshToken: String

    init() {
        self.accessToken = ""
        self.refreshToken = ""
    }
}
