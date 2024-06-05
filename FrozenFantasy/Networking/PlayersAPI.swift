//
//  PlayersAPI.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 08.05.2024.
//

import Alamofire
import Foundation

enum PlayersAPI: API {
    case getPlayers(rarity: String?, league: League?)
    case getPlayerCards(profileID: UUID?, rarity: String?, league: League?, unpacked: Bool?)
    case unpackCard(id: Int)

    var baseURL: String {
        Constants.API.baseURL + "/players"
    }

    var path: String {
        switch self {
        case .getPlayers:
            "/info"
        case .getPlayerCards:
            "/cards"
        case .unpackCard:
            "/cards/unpack"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPlayers, .getPlayerCards:
            .get
        case .unpackCard:
            .post
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .getPlayers(rarity, league):
            var params: [String: String] = [:]
            if let rarity {
                params["rarity"] = rarity
            }
            if let league {
                params["league"] = league.title
            }
            return params

        case let .getPlayerCards(profileID, rarity, league, unpacked):
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
        case .getPlayers, .getPlayerCards, .unpackCard:
            URLEncoding.queryString
        }
    }

    var headers: HTTPHeaders {
        get throws {
            switch self {
            case .getPlayers, .getPlayerCards:
                []
            case .unpackCard:
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
