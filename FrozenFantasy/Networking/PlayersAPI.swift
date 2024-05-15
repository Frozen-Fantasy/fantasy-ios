//
//  PlayersAPI.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 08.05.2024.
//

import Alamofire
import Foundation

enum PlayersAPI: API {
    case playerCards(profileID: UUID?, rarity: String?, league: League?, unpacked: Bool?)

    var baseURL: String {
        Constants.API.baseURL + "/players"
    }

    var path: String {
        switch self {
        case .playerCards:
            "/cards"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .playerCards:
            .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .playerCards(profileID, rarity, league, unpacked):
            var params: [String: String] = [:]
            if let profileID {
                params["profileID"] = profileID.uuidString
            }
            if let rarity {
                params["rarity"] = rarity
            }
            if let league {
                params["league"] = league.title
            }
            if let unpacked {
                params["unpacked"] = String(unpacked)
            }
            return params
        }
    }

    var encoding: any ParameterEncoding {
        switch self {
        case .playerCards:
            URLEncoding.default
        }
    }

    var headers: HTTPHeaders {
        switch self {
        default:
            []
        }
    }

    var url: String {
        baseURL + path
    }

    var reponseType: any Decodable.Type {
        Empty.self
    }
}
