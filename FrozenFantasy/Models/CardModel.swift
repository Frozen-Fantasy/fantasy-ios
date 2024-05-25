//
//  CardModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

typealias Cards = [Card]
struct Card: Codable, Identifiable, Equatable {
    var id: Int = UUID().hashValue
    var profileID: UUID = UUID()
    var playerID: Int = UUID().hashValue

    var rarity: Rarity

    var bonusMetric: Int
    var bonusMetricName: String
    var multiplicator: Double
    var unpacked: Bool

    var name: String
    var sweaterNumber: Int
    var photo: URL

    var teamID: Int = UUID().hashValue
    var teamName: String

    var position: Position
    var league: League

    enum CodingKeys: String, CodingKey {
        case id
        case profileID
        case playerID
        case rarity
        case bonusMetric
        case bonusMetricName
        case multiplicator = "multiply"
        case unpacked
        case name
        case sweaterNumber
        case photo
        case teamID
        case teamName
        case position
        case league
    }
}
