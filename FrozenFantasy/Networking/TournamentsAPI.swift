//
//  TorunamentsAPI.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Alamofire
import Foundation

enum TournamentsAPI: API {
    case getTournaments(showAll: Bool, tournamentID: Int?, league: League?, status: Status?)
    case getMatches(tournamentID: Int)
    case getRoster(tournamentID: Int)

    case getTeam(tournamentID: Int)
    case editTeam(tournamentID: Int, playerIDs: [Int], isNew: Bool)

    case getTournamentResult(tournamentID: Int)

    var baseURL: String {
        Constants.API.baseURL + "/tournament"
    }

    var path: String {
        switch self {
        case .getTournaments:
            "s"
        case let .getMatches(tournamentID):
            "/matches_by_tournament_id/\(tournamentID)"
        case .getRoster:
            "/roster"
        case .getTeam:
            "/team"
        case let .editTeam(tournamentID, _, isNew):
            "/team" + (isNew ? "/create" : "/edit") + "?tournamentID=\(tournamentID)"
        case .getTournamentResult:
            "/results"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getMatches, .getTournaments, .getRoster, .getTeam, .getTournamentResult:
            .get
        case let .editTeam(_, _, isNew):
            isNew ? .post : .put
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .getTournaments(showAll, tournamentID, league, status):
            var parameters: [String: String] = [
                "type": showAll ? "all" : "personal"
            ]

            if let tournamentID {
                parameters["tournamentID"] = String(tournamentID)
            }
            if let league {
                parameters["league"] = league.title
            }
            if let status {
                parameters["status"] = status.rawValue
            }

            return parameters

        case .getMatches:
            return nil

        case let .getRoster(tournamentID),
             let .getTeam(tournamentID),
             let .getTournamentResult(tournamentID):
            return ["tournamentID": tournamentID]

        case let .editTeam(_, playerIDs, _):
            return ["team": playerIDs]
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .getTournaments, .getMatches, .getRoster, .getTeam, .getTournamentResult:
            URLEncoding.default
        case .editTeam:
            JSONEncoding.default
        }
    }

    var headers: HTTPHeaders {
        get throws {
            [.contentType("application/json"),
             try TokenManager.shared.authHeader]
        }
    }

    var url: String {
        baseURL + path
    }

    var reponseType: Decodable.Type {
        Empty.self
    }
}
