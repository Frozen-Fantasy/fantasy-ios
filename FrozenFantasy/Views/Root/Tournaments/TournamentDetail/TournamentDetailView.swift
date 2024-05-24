//
//  TournamentDetailView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct TournamentDetailView: View {
    @StateObject var viewModel = TournamentDetailViewModel()

    let tournament: Tournament
    init(_ tournament: Tournament) {
        self.tournament = tournament
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                info
                matches

                Button {} label: {
                    NavigationLink {
                        TeamView(for: tournament.id)
                    } label: {
                        Text("Участвовать")
                    }
                }
                .buttonStyle(.custom)
            }
            .padding(16)
        }
        .navigationTitle(tournament.title)
        .animation(.default.speed(1.5), value: viewModel.matches)
        .task {
            viewModel.tournamentID = tournament.id
            await viewModel.fetchMatches()
        }
        .refreshable {
            await viewModel.fetchMatches()
        }
        .isTabBarVisible(true)
    }

    // MARK: INf

    var info: some View {
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

    private var matches: some View {
        VStack(alignment: .leading) {
            Text("Матчи")
                .font(.customTitle1)
                .foregroundStyle(.customBlack)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 16) {
                ForEach(viewModel.matches) { match in
                    MatchCardView(match)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        TournamentDetailView(.dummy)
    }
}
