//
//  TokenPair.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

struct TokenPair: Codable {
    var accessToken: String = ""
    var refreshToken: String = ""

    var expirationDate: Date

    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
        case expirationDate = "expiresIn"
    }
}
