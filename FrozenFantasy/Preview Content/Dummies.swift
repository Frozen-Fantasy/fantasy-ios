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
        participating: false,
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

extension CollectionCard: Dummy {
    static var dummy: CollectionCard = .init(
        name: "David Gustaffson",
        photo: URL(string: "https://assets.nhle.com/mugs/nhl/20232024/WPG/8481019.png")!,
        sweaterNumber: 19,

        league: .NHL,
        position: .forward,

        rarity: .silver,
        bonusMetric: 3,
        bonusMetricName: "Голы",
        multiplicator: 1.25,
        unpacked: true,

        teamName: "Winnipeg Jets",
        teamLogo: URL(string: "https://assets.nhle.com/logos/nhl/svg/WPG_light.svg")!
    )
}

extension Player: Dummy {
    static var dummy: Player = .init(
        name: "David Gustaffson",
        photo: URL(string: "https://assets.nhle.com/mugs/nhl/20232024/WPG/8481019.png")!,
        sweaterNumber: 19,

        league: .NHL,
        position: .forward,

        teamName: "Winnipeg Jets",
        teamLogo: URL(string: "https://assets.nhle.com/logos/nhl/svg/WPG_light.svg")!,

        cost: 20,
        averageFP: 30,
        rarity: .silver
    )
}

extension PlayerStats: Dummy {
    static var dummy: PlayerStats = .init(
        name: "David Gustaffson",
        photo: URL(string: "https://assets.nhle.com/mugs/nhl/20232024/WPG/8481019.png")!,
        //        sweaterNumber: 19,

        position: .forward,

        teamName: "Winnipeg Jets",
        teamLogo: URL(string: "https://assets.nhle.com/logos/nhl/svg/WPG_light.svg")!,

        rarity: .silver,
        scoreFP: 36,

        goals: 0,
        assists: 0,
        shots: 0,
        pims: 0,
        hits: 0,
        saves: 0,
        missed: 0,
        shutout: false
    )
}

extension TournamentResult: Dummy {
    static var dummy: TournamentResult = .init(
        nickname: "drunkvermicelli",
        photo: URL(string: "https://cdn1.iconfinder.com/data/icons/sport-avatar-6/64/15-hockey_player-sport-hockey-avatar-people-256.png")!,

        place: 1,
        scoreFP: 36,
        coinsWon: 5000,

        teamStats: [.dummy]
    )
}

extension CollectionCardPack: Dummy {
    static var dummy: CollectionCardPack = .init(
        title: "Набор серебрянных карточек КХЛ",
        image: URL(string: "https://i.postimg.cc/1zVYy9g1/khl-silver.png")!,
        cardCount: 3,
        price: 500,
        league: .KHL,
        rarity: .silver)
}

extension MatchStats: Dummy {
    static var dummy: MatchStats = .init(
        date: .now.advanced(by: -60*60*10),
        opponent: "COL",
        scoreFP: 15.1,
        goals: 1,
        assists: 4,
        shots: 3,
        pims: 2,
        hits: 4,
        saves: 0,
        missed: 3,
        shutout: true)
}
