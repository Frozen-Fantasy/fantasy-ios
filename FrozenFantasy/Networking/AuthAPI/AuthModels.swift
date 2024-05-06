//
//  AuthModels.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 21.04.2024.
//

import Foundation

struct TokenPair: Codable {
    var accessToken: String = ""
    var refreshToken: String = ""

    var expiresIn: Int = 0
    var expirationDate: Date {
        get {
            .now.advanced(by: TimeInterval(expiresIn))
        }
        set {
            expiresIn = Int(newValue.timeIntervalSinceNow)
        }
    }

    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
        case expiresIn
    }
}
