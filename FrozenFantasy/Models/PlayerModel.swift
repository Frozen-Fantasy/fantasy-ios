//
//  PlayerModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 23.05.2024.
//

import Foundation

typealias Players = [Player]
struct Player: Identifiable, Codable, Equatable, Hashable {
    var id: Int = UUID().hashValue
    var name: String
    var photo: URL

    var league: League
    var sweaterNumber: Int
    var position: Position

    var teamID: Int = UUID().hashValue
    var teamName: String
    var teamLogo: URL

    var cost: Double
    var averageFP: Double
    var rarity: Rarity

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo

        case league
        case sweaterNumber
        case position

        case teamID
        case teamName
        case teamLogo

        case cost = "playerCost"
        case averageFP = "avgFantasyPoints"
        case rarity = "cardRarity"
    }
}

struct Roster: Codable {
    var players: Players
}
