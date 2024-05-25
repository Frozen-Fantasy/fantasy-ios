//
//  SharedModels.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation
import SwiftUI

enum Status: String, Codable {
    case notStarted = "not_yet_started",
         started,
         finished
}

enum League: Int, Codable, CaseIterable {
    case NHL = 1,
         KHL = 2

    var title: String {
        switch self {
        case .KHL:
            "KHL"
        case .NHL:
            "NHL"
        }
    }
}

enum Position: Int, Codable, CaseIterable {
    case goaltender = 1,
         defender = 2,
         forward = 3

    var abbreviation: String {
        switch self {
        case .goaltender:
            "G"
        case .defender:
            "D"
        case .forward:
            "F"
        }
    }

    var title: String {
        switch self {
        case .goaltender:
            "Вратарь"
        case .defender:
            "Защитник"
        case .forward:
            "Нападающий"
        }
    }

    var color: Color {
        switch self {
        case .goaltender:
            .customBlack
        case .defender:
            .customBlue
        case .forward:
            .customOrange
        }
    }
}

enum Rarity: Int, Codable, CaseIterable {
    case none = 0,
         silver = 1,
         gold = 2

    var color: Color {
        switch self {
        case .none:
            .clear
        case .silver:
            .customGray
        case .gold:
            .customYellow
        }
    }
}
