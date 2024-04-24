//
//  AuthAPI.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 05.03.2024.
//

import Alamofire
import Foundation

enum AuthAPI: API {
    case sendEmail(email: String)
    case logout
    case refreshTokens
    case signIn(email: String, password: String)
    case signUp(code: Int, email: String, nickname: String, password: String)
    
    var baseURL: String {
        Constants.API.baseURL + "/auth"
    }
    
    var path: String {
        switch self {
        case .sendEmail:
            "/email/send-code"
        case .logout:
            "/logout"
        case .refreshTokens:
            "/refresh-tokens"
        case .signIn:
            "/sign-in"
        case .signUp:
            "/sign-up"
        }
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        switch self {
        case let .signIn(email, password):
            ["email": email,
             "password": password]
        case let .sendEmail(email):
            ["email": email]
        case let .signUp(code, email, nickname, password):
            ["code": code,
             "email": email,
             "nickname": nickname,
             "password": password]
        default:
            nil
        }
    }
    
    var encoding: ParameterEncoding {
        JSONEncoding.default
    }

    var headers: HTTPHeaders {
        [.contentType("application/json")]
    }
    
    var url: String {
        baseURL + path
    }
    
    var reponseType: Decodable.Type {
        Empty.self
    }
}
