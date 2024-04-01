//
//  API.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 05.03.2024.
//

import Foundation
import Alamofire

protocol API {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders { get }
    var url: String { get }
    var reponseType: Decodable.Type {get}
}

enum APIError: Error {
    case badRequst
    case unauthorized
    case serverDown
    case failedWithStatusCode(code: Int)
}
