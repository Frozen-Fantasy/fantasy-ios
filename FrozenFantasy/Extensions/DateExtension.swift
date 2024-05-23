//
//  DateExtension.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 06.05.2024.
//

import Alamofire
import Foundation

extension JSONDecoder {
    static let custom: JSONDecoder = {
        let longISO8601DateFormatter = ISO8601DateFormatter()
        longISO8601DateFormatter.formatOptions.insert(.withFractionalSeconds)
        //        longISO8601DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()

            // UNIX Time
            if let timeSince1970 = try? container.decode(TimeInterval.self) {
                return Date(timeIntervalSince1970: timeSince1970)
            }

            let dateString = try container.decode(String.self)

            // IS08601 w/o ms
            if let date = ISO8601DateFormatter().date(from: dateString) { return date }

            // ISO8601 with ms
            if let date = longISO8601DateFormatter.date(from: dateString) { return date }

            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date: '\(dateString)'")
        }

        return decoder
    }()
}
