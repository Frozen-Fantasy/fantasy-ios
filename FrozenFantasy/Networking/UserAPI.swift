//
//  UserAPI.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Alamofire
import Foundation

enum UserAPI: API {
    case exists(email: String?, username: String?)
    case info
    case transactions

    var baseURL: String {
        Constants.API.baseURL + "/user"
    }

    var path: String {
        switch self {
        case .exists:
            "/exists"
        case .info:
            "/info"
        case .transactions:
            "/transactions"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .exists, .info, .transactions:
            .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .exists(email, username):
            if let email { ["email": email] } else if let username { ["nickname": username] } else { nil }
        default:
            nil
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        default:
            URLEncoding.default
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .exists:
            []
        case .info, .transactions:
            [TokenManager.shared.authHeader]
        }
    }

    var url: String {
        baseURL + path
    }

    var reponseType: Decodable.Type {
        Empty.self
    }
}
