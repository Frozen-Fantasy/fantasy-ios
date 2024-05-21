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

    var homeTeamID: Int = UUID().hashValue
    var homeTeamAbbr: String
    var homeTeamScore: Int

    var awayTeamID: Int = UUID().hashValue
    var awayTeamAbbr: String
    var awayTeamScore: Int

    var startsAt: TimeInterval
    var endsAt: TimeInterval

    var league: League

    enum CodingKeys: String, CodingKey {
        case id = "matchId"
        case homeTeamID = "homeTeamId"
        case homeTeamAbbr = "homeTeamAbrev"
        case homeTeamScore = "homeScore"
        case awayTeamID = "awayTeamId"
        case awayTeamAbbr = "awayTeamAbrev"
        case awayTeamScore = "awayScore"
        case startsAt = "startAt"
        case endsAt = "endAt"
        case league
    }
}
