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
    var sweaterNumber: Int

    var league: League
    var position: Position

    var teamName: String
    var teamLogo: URL

    var cost: Double
    var averageFP: Double
    var rarity: Rarity

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo
        case sweaterNumber

        case league
        case position

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

struct PlayerStats: Identifiable, Codable {
    var id: Int = UUID().hashValue
    var name: String
    var photo: URL
    var sweaterNumber: Int

    var league: League
    var position: Position

    var teamName: String
    var teamLogo: URL

    var rarity: Rarity
    var scoreFP: Double

    var goals: Int
    var assits: Int
    var shots: Int
    var pims: Int
    var hits: Int
    var saves: Int
    var missed: Int
    var shutout: Bool

    enum CodingKeys: String, CodingKey {
        case id = "playerID"
        case name
        case photo
        case sweaterNumber

        case league
        case position

        case teamName
        case teamLogo

        case rarity
        case scoreFP = "fantasyPoint"

        case goals
        case assits
        case shots
        case pims
        case hits
        case saves
        case missed
        case shutout
    }
}
