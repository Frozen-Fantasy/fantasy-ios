//
//  MatchModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

typealias Matches = [Match]
struct Match: Codable, Identifiable, Equatable {
    var id: Int = UUID().hashValue
    var league: League
    var status: Status

    var homeTeamID: Int = UUID().hashValue
    var homeTeamAbbr: String
    var homeTeamLogo: URL
    var homeTeamScore: Int

    var awayTeamID: Int = UUID().hashValue
    var awayTeamAbbr: String
    var awayTeamLogo: URL
    var awayTeamScore: Int

    var startsAt: Date
    var endsAt: Date

    enum CodingKeys: String, CodingKey {
        case id = "matchId"
        case league
        case status = "statusEvent"

        case homeTeamID = "homeTeamId"
        case homeTeamAbbr = "homeTeamAbbrev"
        case homeTeamLogo
        case homeTeamScore = "homeScore"

        case awayTeamID = "awayTeamId"
        case awayTeamAbbr = "awayTeamAbbrev"
        case awayTeamLogo
        case awayTeamScore = "awayScore"

        case startsAt = "startAt"
        case endsAt = "endAt"
    }
}
