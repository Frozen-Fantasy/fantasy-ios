//
//  SharedModels.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

enum League: Int, Codable, CaseIterable {
    case both = 0,
         NHL = 1,
         KHL = 2

    var title: String {
        switch self {
        case .both:
            "Both"
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
}
