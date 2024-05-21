//
//  TournamentModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

typealias Tournaments = [Tournament]
struct Tournament: Codable, Identifiable {
    var id: Int = UUID().hashValue
    var title: String
    var league: League

    var startDate: Date
    var endDate: Date

    var players: Int
    var deposit: Int
    var prizeFund: Int

    var status: Status = .notStarted
    enum Status: String, Codable {
        case notStarted = "not_yet_started",
             started,
             finished

        var displayed: String {
            switch self {
            case .started:
                "Текущий"
            case .notStarted:
                "Предстоящий"
            case .finished:
                "Закончился"
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "tournamentId"
        case league
        case title
        case startDate = "timeStartTS"
        case endDate = "timeEndTS"
        case players = "playersAmount"
        case deposit
        case prizeFund = "prizeFond"
        case status = "statusTournament"
    }
}
