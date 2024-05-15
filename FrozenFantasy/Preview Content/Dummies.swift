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
                                         league: .NHL,
                                         // TODO: Temporary fix
                                         startDate: 1000*Date.now.advanced(by: 600).timeIntervalSince1970,
                                         endDate: 1000*Date.now.advanced(by: 87000).timeIntervalSince1970,
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

extension Card: Dummy {
    static var dummy: Card = .init(profileID: UUID(),
                                   playerID: 0,
                                   rarity: .silver,
                                   bonusMetric: 3,
                                   bonusMetricName: "Голы",
                                   multiplicator: 1.25,
                                   unpacked: true,
                                   name: "David Gustaffson",
                                   sweaterNumber: 19,
                                   photo: URL(string: "https://assets.nhle.com/mugs/nhl/20232024/WPG/8481019.png")!,
                                   teamID: 22,
                                   teamName: "Winnipeg Jets",
                                   position: .forward,
                                   league: .NHL)
}
