//
//  StoreAPI.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.06.2024.
//

import Foundation
import Alamofire

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
        case let .buyProduct(id):
            "/prodcuts/buy"
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
        URLEncoding.default
    }

    var headers: Alamofire.HTTPHeaders {
        []
    }

    var url: String {
        baseURL + path
    }

    var reponseType: any Decodable.Type {
        Empty.self
    }
}
