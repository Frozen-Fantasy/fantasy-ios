//
//  CardModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

struct CollectionCard: Codable, Identifiable, Equatable {
    var id: Int = UUID().hashValue
    var profileID: UUID = UUID()
    var playerID: Int = UUID().hashValue

    var name: String
    var photo: URL
    var sweaterNumber: Int

    var league: League
    var position: Position

    var rarity: Rarity
    var bonusMetric: Int
    var bonusMetricName: String
    var multiplicator: Double
    var unpacked: Bool

    var teamID: Int = UUID().hashValue
    var teamName: String
    var teamLogo: URL

    enum CodingKeys: String, CodingKey {
        case id
        case profileID
        case playerID

        case name
        case photo
        case sweaterNumber

        case league
        case position

        case rarity
        case bonusMetric
        case bonusMetricName
        case multiplicator = "multiply"
        case unpacked

        case teamID
        case teamName
        case teamLogo
    }
}
