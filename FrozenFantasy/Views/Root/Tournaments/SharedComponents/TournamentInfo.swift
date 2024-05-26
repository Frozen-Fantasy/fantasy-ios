//
//  TournamentInfo.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 26.05.2024.
//

import SwiftUI

struct TournamentInfo: View {
    let tournament: Tournament

    init(_ tournament: Tournament) {
        self.tournament = tournament
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Информация")
                .font(.customTitle1)
                .foregroundStyle(.customBlack)

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 12) {
                    startSegment
                    coinsSegment
                }

                Spacer()

                VStack(alignment: .leading, spacing: 12) {
                    endSegment
                    playersSegment
                }

                Spacer()
            }
        }
    }

    private func format(_ date: Date) -> String {
        date.formatted(date: .numeric, time: .shortened)
    }

    private var startSegment: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Начало")
                .font(.customBody1)
                .foregroundStyle(.customBlack)

            CustomLabel(format(tournament.startDate), image: "icon:calendar")
        }
    }

    private var endSegment: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Конец")
                .font(.customBody1)
                .foregroundStyle(.customBlack)

            CustomLabel(format(tournament.endDate), image: "icon:calendar")
        }
    }

    private var playersSegment: some View {
        HStack(spacing: 12) {
            Text("Игроки")
                .font(.customBody1)
                .foregroundStyle(.customBlack)

            CustomLabel(tournament.players.formatted(), image: "icon:group")
        }
    }

    private var coinsSegment: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Взнос")
                Text("Фонд")
            }
            .font(.customBody1)
            .foregroundStyle(.customBlack)

            VStack(alignment: .leading, spacing: 4) {
                CoinLabel(tournament.deposit)
                CoinLabel(tournament.prizeFund)
            }
        }
    }
}

#Preview {
    TournamentInfo(.dummy)
        .padding()
}
