//
//  MatchStatsCard.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 04.06.2024.
//

import SwiftUI

struct MatchStatsCard: View {
    let matchStats: MatchStats
    let position: Position

    init(_ matchStats: MatchStats, playerPosition: Position) {
        self.matchStats = matchStats
        self.position = playerPosition
    }

    var body: some View {
        VStack {
            HStack {
                Text("\(matchStats.date.formatted(date: .numeric, time: .omitted)) @ \(matchStats.opponent)")
                    .bold()

                Spacer()

                Text("Очки")
                FantasyPointLabel(matchStats.scoreFP)
            }
            .font(.customBody1)
            .foregroundStyle(.customBlack)

            HStack {
                switch position {
                case .goaltender:
                    StatLabel("SV", value: matchStats.saves)
                    Spacer()
                    StatLabel("GA", value: matchStats.missed)
                    Spacer()
                    StatLabel("PIM", value: matchStats.pims)
                    Spacer()
                    if matchStats.shutout {
                        Text("SO")
                        Spacer()
                    }
                case .defender, .forward:
                    StatLabel("G", value: matchStats.goals)
                    Spacer()
                    StatLabel("A", value: matchStats.assists)
                    Spacer()
                    StatLabel("HIT", value: matchStats.hits)
                    Spacer()
                    StatLabel("S", value: matchStats.shots)
                    Spacer()
                    StatLabel("PIM", value: matchStats.pims)
                    Spacer()
                }
            }
            .font(.customBody1)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
    }
}

#Preview {
    VStack {
        MatchStatsCard(.dummy, playerPosition: .forward)
        MatchStatsCard(.dummy, playerPosition: .goaltender)
    }
    .padding()
}
