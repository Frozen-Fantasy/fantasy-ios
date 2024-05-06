//
//  UserModels.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 27.04.2024.
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    var id: UUID = .init()
    var nickname: String = ""
    var email: String = ""
    var registrationDate: Date = .now
    var photo: URL?
    var coins: Int = 0

    enum CodingKeys: String, CodingKey {
        case id = "profileID"
        case nickname
        case email
        case registrationDate = "dateRegistration"
        case photo = "photoLink"
        case coins
    }
}

typealias Transactions = [Transaction]
struct Transaction: Identifiable, Codable, Equatable {
    var id: Int = UUID().hashValue
    var amount: Int
    var details: String
    var date: Date

    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case details = "transactionDetails"
        case date = "transactionDate"
    }
}

extension Transactions {
    var groupedByDate: [Date: Transactions] {
        .init(grouping: self.sorted { $0.date > $1.date }) { transaction in
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: transaction.date)
            return Calendar.current.date(from: dateComponents)!
        }
    }
}
