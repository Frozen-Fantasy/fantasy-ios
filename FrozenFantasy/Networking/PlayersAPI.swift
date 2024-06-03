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
    case unpackCard(id: Int)

    var baseURL: String {
        Constants.API.baseURL + "/players"
    }

    var path: String {
        switch self {
        case .playerCards:
            "/cards"
        case .unpackCard:
            "/cards/unpack"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .playerCards:
            .get
        case .unpackCard:
            .post
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

        case let .unpackCard(id):
            return ["id": id]
        }
    }

    var encoding: any ParameterEncoding {
        switch self {
        case .playerCards, .unpackCard:
            URLEncoding.queryString
        }
    }

    var headers: HTTPHeaders {
        get throws {
            switch self {
            case .playerCards:
                []
            default:
                try [TokenManager.shared.authHeader]
            }
        }
    }

    var url: String {
        baseURL + path
    }

    var reponseType: any Decodable.Type {
        Empty.self
    }
}
