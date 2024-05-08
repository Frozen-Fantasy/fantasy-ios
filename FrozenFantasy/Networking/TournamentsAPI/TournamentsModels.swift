//
//  TournamentsModels.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Foundation

enum League: String, CaseIterable {
    case both = "Both", NHL, KHL
}

typealias Tournaments = [Tournament]
struct Tournament: Codable, Identifiable {
    var id: Int = UUID().hashValue
    var title: String

    var leagueID: Int
    var league: League {
        .allCases[leagueID]
    }

    var matchesIDs: [Int]

    var startDate: TimeInterval
    var endDate: TimeInterval

    var players: Int
    var deposit: Int
    var prizeFund: Int

    enum Status: String, Codable {
        case started,
             notStarted = "not_yet_started"

        var displayed: String {
            switch self {
            case .started:
                "Текущий"
            case .notStarted:
                "Предстоящий"
            }
        }
    }

    var status: Status = .notStarted

    enum CodingKeys: String, CodingKey {
        case id = "tournamentId"
        case leagueID = "league"
        case title
        case matchesIDs = "matchesIds"
        case startDate = "TimeStart"
        case endDate = "timeEnd"
        case players = "playersAmount"
        case deposit
        case prizeFund = "prizeFond"
        case status = "statusTournament"
    }
}
