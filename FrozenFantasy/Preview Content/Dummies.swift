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
    static var dummy: Tournament = .init(
        title: "NHL Daily Tournament",
        league: .NHL,
        status: .notStarted,
        participatingString: "false",
        startDate: .now.advanced(by: 600),
        endDate: .now.advanced(by: 87000),
        players: 13,
        deposit: 100,
        prizeFund: 5000
    )
}

extension User: Dummy {
    static let dummy: User = .init(
        nickname: "drunkvermicelli",
        email: "nasigal@edu.hse.ru",
        registrationDate: .now.advanced(by: -600000),
        photo: URL(string: "https://cdn1.iconfinder.com/data/icons/sport-avatar-6/64/15-hockey_player-sport-hockey-avatar-people-256.png")!,
        coins: 212
    )
}

extension Transactions: Dummy {
    static var dummy: Transactions = [
        .init(amount: -500, details: "Покупка: Набор серебряных карточек НХЛ", date: .now.advanced(by: -60)),
        .init(amount: 100, details: "Выигрыш: NHL Daily Battle", date: .now.advanced(by: -24*60*60 - 60)),
        .init(amount: 6577, details: "Выигрыш: KHL Daily Tournament", date: .now.advanced(by: -24*60*60))
    ]
}

extension Card: Dummy {
    static var dummy: Card = .init(
        rarity: .silver,
        bonusMetric: 3,
        bonusMetricName: "Голы",
        multiplicator: 1.25,
        unpacked: true,
        name: "David Gustaffson",
        sweaterNumber: 19,
        photo: URL(string: "https://assets.nhle.com/mugs/nhl/20232024/WPG/8481019.png")!,
        teamName: "Winnipeg Jets",
        position: .forward,
        league: .NHL
    )
}

extension Match: Dummy {
    static var dummy: Match = .init(
        league: .NHL,
        status: .notStarted,

        homeTeamAbbr: "FLA",
        homeTeamLogo: URL(string: "https://assets.nhle.com/logos/nhl/svg/FLA_light.svg")!,
        homeTeamScore: 0,

        awayTeamAbbr: "COL",
        awayTeamLogo: URL(string: "https://assets.nhle.com/logos/nhl/svg/COL_light.svg")!,
        awayTeamScore: 0,

        startsAt: .now.advanced(by: 8*60*60),
        endsAt: .now.advanced(by: 10*60*60)
    )
}
