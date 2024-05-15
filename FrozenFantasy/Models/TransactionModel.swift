//
//  TransactionModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

typealias Transactions = [Transaction]
struct Transaction: Codable, Identifiable, Equatable {
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
