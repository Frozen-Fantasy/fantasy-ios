//
//  NetworkManager.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 05.03.2024.
//

import Alamofire
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()

    func request(endpoint: API) -> DataRequest {
        AF.request(endpoint.url,
                   method: endpoint.method,
                   parameters: endpoint.parameters,
                   encoding: endpoint.encoding,
                   headers: endpoint.headers)
    }
}

extension DataRequest {
    func data<T: Decodable>(as type: T.Type = Empty.self) async throws -> T {
        do {
            return try await self.validate().serializingDecodable(type, decoder: JSONDecoder.custom).value
        } catch let AFError.responseValidationFailed(reason: .unacceptableStatusCode(code)) {
            if let data {
                debugPrint(try! JSONDecoder().decode([String: String].self, from: data))
            }

            switch code {
            case 400:
                throw APIError.badRequest
            case 401:
                throw APIError.unauthorized
            case 500:
                throw APIError.serverDown
            default:
                throw APIError.failedWithStatusCode(code: code)
            }
        } catch let AFError.responseSerializationFailed(reason) {
            debugPrint(reason)
            fatalError("Unable to decode response into type '\(type)'")
        } catch {
            fatalError(error.asAFError?.localizedDescription ?? "Unexpected error")
        }
    }
}
