//
//  StoreAPI.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.06.2024.
//

import Alamofire
import Foundation

enum StoreAPI: API {
    case getProducts,
         buyProduct(id: Int)

    var baseURL: String {
        Constants.API.baseURL + "/store"
    }

    var path: String {
        switch self {
        case .getProducts:
            "/products"
        case .buyProduct:
            "/products/buy"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .getProducts:
            .get
        case .buyProduct:
            .post
        }
    }

    var parameters: Alamofire.Parameters? {
        switch self {
        case .getProducts:
            nil
        case let .buyProduct(id):
            ["id": id]
        }
    }

    var encoding: any Alamofire.ParameterEncoding {
        URLEncoding.queryString
    }

    var headers: Alamofire.HTTPHeaders {
        get throws {
            switch self {
            case .getProducts:
                []
            case .buyProduct:
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
