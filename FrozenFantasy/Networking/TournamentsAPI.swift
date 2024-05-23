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

    var baseURL: String {
        Constants.API.baseURL + "/tournament"
    }

    var path: String {
        switch self {
        case .getTournaments:
            "s"
        case let .getMatches(tournamentID):
            "/matches_by_tournament_id/\(tournamentID)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getMatches, .getTournaments:
            .get
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
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .getMatches, .getTournaments:
            URLEncoding.default
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .getTournaments, .getMatches:
            [.contentType("application/json"),
             TokenManager.shared.authHeader]
        }
    }

    var url: String {
        baseURL + path
    }

    var reponseType: Decodable.Type {
        Empty.self
    }
}
