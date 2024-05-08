//
//  NetworkManager.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 05.03.2024.
//

import Alamofire
import Foundation
import os

final class AlamofireLogger: EventMonitor {
    private let logger = Logger()

    func requestDidResume(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        logger.info("""
        ⬆ \(request)
        Body: \(body)
        """)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        let body = String(decoding: response.data ?? Data(), as: UTF8.self)
        logger.log(level: response.error == nil ? .info : .error,
                   """
                   ⬇ \(request)
                   Body: \(body)
                   """)
    }
}

final class NetworkManager {
    static let shared = NetworkManager()

    private let session = Session(eventMonitors: [AlamofireLogger()])

    @discardableResult
    func request<T: Decodable>(from endpoint: API, expecting type: T.Type = Empty.self) async throws -> T {
        let request = session.request(endpoint.url,
                                      method: endpoint.method,
                                      parameters: endpoint.parameters,
                                      encoding: endpoint.encoding,
                                      headers: endpoint.headers)

        do {
            return try await request
                .validate()
                .serializingDecodable(type, automaticallyCancelling: false, decoder: JSONDecoder.custom)
                .value
        } catch AFError.responseValidationFailed(reason: .unacceptableStatusCode(400)) {
            if let details = try? JSONDecoder().decode(APIError.Details.self, from: request.data ?? Data()) {
                throw APIError.badRequest(reason: details.message)
            } else {
                fatalError("Unexpected networking error")
            }
        } catch let AFError.responseSerializationFailed(reason) {
            debugPrint(reason)
            fatalError("Unable to decode response into type '\(type)'")
        } catch {
            fatalError(error.asAFError?.localizedDescription ?? "Unexpected error")
        }
    }
}
