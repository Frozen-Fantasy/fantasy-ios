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
            .validate()
    }
}

extension DataRequest {
    func data<T: Decodable>(as type: T.Type = Empty.self) async throws -> T {
        do {
            return try await self.serializingDecodable(type).value
        } catch let AFError.responseValidationFailed(reason: .unacceptableStatusCode(code)) {
            responseDecodable(of: [String: String].self) { response in
                debugPrint(response)
            }
            
            switch code {
            case 400:
                throw APIError.badRequst
            case 401:
                throw APIError.unauthorized
            case 500:
                throw APIError.serverDown
            default:
                throw APIError.failedWithStatusCode(code: code)
            }
        } catch (AFError.responseSerializationFailed(_)) {
            fatalError("Unable to decode response into type '\(type)'")
        } catch {
            print(error)
            fatalError()
        }
    }
}
