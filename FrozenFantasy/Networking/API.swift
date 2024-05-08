//
//  API.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 05.03.2024.
//

import Alamofire
import Foundation

protocol API {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders { get }
    var url: String { get }
    var reponseType: Decodable.Type { get }
}

enum APIError: Error {
    struct Details: Codable {
        var error: String
        var message: String
    }

    case badRequest(reason: String)
    case noConnection
    case failedWithStatusCode(code: Int)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest(let reason):
            reason
        case .noConnection:
            "Не удалось установить соединение с сервером. Проверьте подключение и попробуйте позже."
        case .failedWithStatusCode(let code):
            "Код ошибки: \(code)"
        }
    }
}
