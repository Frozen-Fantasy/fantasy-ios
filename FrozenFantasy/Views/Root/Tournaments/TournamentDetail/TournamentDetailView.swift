//
//  TournamentDetailView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct TournamentDetailView: View {
    @StateObject var viewModel = TournamentDetailViewModel()

    let initialTournament: Tournament
    init(_ tournament: Tournament) {
        self.initialTournament = tournament
    }

    var tournament: Tournament {
        viewModel.tournament ?? initialTournament
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                info
                matches

                if tournament.participating {
                    myTeam
                } else {
                    Button {} label: {
                        NavigationLink {
                            EditTeamView(of: tournament)
                        } label: {
                            Text("Участвовать")
                        }
                    }
                    .buttonStyle(.custom)
                }
            }
            .padding(16)
        }
        .navigationTitle(tournament.title)
        .animation(.default.speed(1.5), value: viewModel.matches)
        .animation(.default.speed(1.5), value: viewModel.players)
        .task {
            viewModel.tournament = tournament
            await viewModel.fetchTournament()
            await viewModel.fetchMatches()
            if tournament.participating {
                await viewModel.fetchTeam()
            }
        }
        .refreshable {
            await viewModel.fetchTournament()
            await viewModel.fetchMatches()
            if tournament.participating {
                await viewModel.fetchTeam()
            }
        }
        .isTabBarVisible(true)
    }

    // MARK: Info

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

    // MARK: Matches

    private var matches: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Матчи")
                .font(.customTitle1)
                .foregroundStyle(.customBlack)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 16) {
                ForEach(viewModel.matches) { match in
                    MatchCard(match)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: My Team

    private var myTeam: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                Text("Моя команда")
                    .font(.customTitle1)
                    .foregroundStyle(.customBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                if tournament.status == .notStarted {
                    Button {} label: {
                        NavigationLink {
                            EditTeamView(of: tournament, currentTeam: viewModel.players)
                        } label: {
                            Label {
                                Text("Изменить")
                            } icon: {
                                Image("icon:edit")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                    .foregroundStyle(.customBlue)
                            }
                        }
                    }
                    .buttonStyle(.customText)
                }
            }

            VStack(spacing: 8) {
                ForEach(viewModel.players) { player in
                    PlayerCard(player)
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
