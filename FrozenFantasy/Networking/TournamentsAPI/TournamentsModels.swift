//
//  TournamentsModels.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Foundation

enum League: String, CaseIterable {
    case Both, NHL, KHL
}

struct Tournament: Codable, Identifiable {
    var id: Int = 0
    var title: String = ""
    
    var leagueID: Int = 0
    var league: League {
        .allCases[leagueID]
    }
    
    var matchesIDs: [Int] = []
    
    // TODO: TEMPORARY FIX
    var startDate: TimeInterval = 1000 * Date.now.advanced(by: 600).timeIntervalSince1970
    var endDate: TimeInterval = 1000 * Date.now.advanced(by: 86400).timeIntervalSince1970
    
    var players: Int = 0
    var deposit: Int = 0
    var prizeFund: Int = 0
    
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
