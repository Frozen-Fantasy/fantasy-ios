//
//  TorunamentsAPI.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Alamofire
import Foundation

enum TournamentsAPI: API {
    case getMatches(league: League)
    case getTournaments(league: League)

    var baseURL: String {
        Constants.API.baseURL + "/tournament"
    }

    var path: String {
        switch self {
        case let .getMatches(league):
            "/get_matches/\(league)"
        case let .getTournaments(league):
            "/get_tournaments/\(league)"
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
        case .getMatches, .getTournaments:
            nil
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .getMatches, .getTournaments:
            JSONEncoding.default
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .getMatches, .getTournaments:
            [.contentType("application/json")]
        }
    }

    var url: String {
        baseURL + path
    }

    var reponseType: Decodable.Type {
        switch self {
        case .getTournaments:
            [Tournament].self
        default:
            Empty.self
        }
    }
}
