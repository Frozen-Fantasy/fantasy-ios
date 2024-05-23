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
    var status: Status

    var participatingString: String
    var participating: Bool {
        participatingString == "true"
    }

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
        case participatingString = "statusParticipation"

        case startDate = "timeStartTS"
        case endDate = "timeEndTS"

        case players = "playersAmount"
        case deposit
        case prizeFund = "prizeFond"
    }
}
