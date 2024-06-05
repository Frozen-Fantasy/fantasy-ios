//
//  PlayerModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 23.05.2024.
//

import Foundation

protocol PlayerCommon {
    var name: String { get }
    var photo: URL { get }
    var position: Position { get }
    //    var sweaterNumber: Int { get }
    var rarity: Rarity { get }

    var teamName: String { get }
    var teamLogo: URL { get }
}

typealias Players = [Player]
struct Player: PlayerCommon, Identifiable, Codable, Equatable, Hashable {
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

struct PlayerStats: PlayerCommon, Identifiable, Codable, Equatable {
    var id: Int = UUID().hashValue
    var name: String
    var photo: URL
    //    var sweaterNumber: Int

    var position: Position

    var teamName: String
    var teamLogo: URL

    var rarity: Rarity
    var scoreFP: Double

    var goals: Int
    var assists: Int
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
        //        case sweaterNumber

        case position

        case teamName
        case teamLogo

        case rarity
        case scoreFP = "fantasyPoint"

        case goals
        case assists
        case shots
        case pims
        case hits
        case saves
        case missed = "missedGoals"
        case shutout
    }
}

struct MatchStats: Codable, Identifiable, Equatable {
    var id: Int = UUID().hashValue
    var date: Date

    var league: League
    var opponent: String

    var scoreFP: Double

    var goals: Int
    var assists: Int
    var shots: Int
    var pims: Int
    var hits: Int
    var saves: Int
    var missed: Int
    var shutout: Bool

    enum CodingKeys: String, CodingKey {
        case id = "matchIdLocal"
        case date = "gameDate"

        case league
        case opponent

        case scoreFP = "fantasyPoint"

        case goals
        case assists
        case shots
        case pims
        case hits
        case saves
        case missed
        case shutout
    }
}
