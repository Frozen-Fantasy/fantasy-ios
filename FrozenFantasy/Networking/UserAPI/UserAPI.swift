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
    
    var baseURL: String {
        Constants.API.baseURL + "/user"
    }
    
    var path: String {
        switch self {
        case .exists:
            "/exists"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .exists:
            .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .exists(email, username):
            if let email { ["email": email] }
            else if let username { ["nickname": username] }
            else { nil }
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .exists:
            URLEncoding.default
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .exists:
            []
        }
    }
    
    var url: String {
        baseURL + path
    }
    
    var reponseType: Decodable.Type {
        Empty.self
    }
}
