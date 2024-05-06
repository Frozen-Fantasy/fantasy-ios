//
//  DateExtension.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 06.05.2024.
//

import Foundation
import Alamofire

extension Date {
    private static let simpleDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

    var simpleDateString: String {
        Date.simpleDateFormatter.string(from: self)
    }
}

extension JSONDecoder {
    static let custom: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            return dateFormatter.date(from: dateString)!
        })

        return decoder
    }()
}
