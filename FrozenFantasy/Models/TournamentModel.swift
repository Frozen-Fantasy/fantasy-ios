//
//  TournamentModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

typealias Tournaments = [Tournament]
struct Tournament: Codable, Identifiable, Equatable {
    var id: Int = UUID().hashValue
    var title: String
    var league: League
    var status: Status
    var participating: Bool

    var startDate: Date
    var endDate: Date

    var players: Int
    var deposit: Int
    var prizeFund: Int

    enum CodingKeys: String, CodingKey {
        case id = "tournamentId"
        case title
        case league
        case status = "statusTournament"
        case participating = "statusParticipation"

        case startDate = "timeStartTS"
        case endDate = "timeEndTS"

        case players = "playersAmount"
        case deposit
        case prizeFund = "prizeFond"
    }
}

struct TournamentResult: Codable {
    var winner: String
    var winnerPhoto: URL

    var place: Int
    var scoreFP: Int
    var coinsWon: Int

    var teamStats: [PlayerStats]

    enum CodingKeys: String, CodingKey {
        case winner = "nickname"
        case winnerPhoto = "userPhoto"

        case place
        case scoreFP = "fantasyPoints"
        case coinsWon = "coins"

        case teamStats = "userTeam"
    }
}
