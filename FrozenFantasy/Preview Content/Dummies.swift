//
//  Dummies.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 27.04.2024.
//

import Foundation

protocol Dummy {
    static var dummy: Self { get }
}

extension Tournament: Dummy {
    static var dummy: Tournament = .init(title: "NHL Daily Tournament",
                                         leagueID: 1,
                                         matchesIDs: [],
                                         // TODO: Temporary fix
                                         startDate: 1000 * Date.now.advanced(by: 600).timeIntervalSince1970,
                                         endDate: 1000 * Date.now.advanced(by: 87000).timeIntervalSince1970,
                                         players: 13,
                                         deposit: 100,
                                         prizeFund: 5000)
}

extension User: Dummy {
    static let dummy: User = .init(nickname: "drunkvermicelli",
                                   email: "nasigal@edu.hse.ru",
                                   registrationDate: .now.advanced(by: -600000),
                                   photo: URL(string: "https://cdn1.iconfinder.com/data/icons/sport-avatar-6/64/15-hockey_player-sport-hockey-avatar-people-256.png")!,
                                   coins: 212)
}

extension Transactions: Dummy {
    static var dummy: Transactions = [
        .init(amount: -500, details: "Покупка: Набор серебряных карточек НХЛ", date: .now.advanced(by: -60)),
        .init(amount: 100, details: "Выигрыш: NHL Daily Battle", date: .now.advanced(by: -24*60*60 - 60)),
        .init(amount: 6577, details: "Выигрыш: KHL Daily Tournament", date: .now.advanced(by: -24*60*60))
    ]
}
