//
//  TournamentDetailView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct TournamentDetailView: View {
    @EnvironmentObject private var userStore: UserStore
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
                TournamentInfo(tournament)
                TournamentMatches(viewModel.matches)

                if tournament.participating {
                    myTeam
                } else {
                    Button {} label: {
                        NavigationLink {
                            EditTeamView(of: tournament)
                        } label: {
                            Text("Собрать команду")
                        }
                    }
                    .buttonStyle(.custom)
                }
            }
            .padding(16)
        }
        .navigationTitle(tournament.title)
        .animation(.default.speed(1.5), value: tournament)
        .animation(.default.speed(1.5), value: viewModel.matches)
        .animation(.default.speed(1.5), value: viewModel.players)
        .task {
            viewModel.tournament = tournament
            await viewModel.fetchAll()
            await userStore.fetchUserInfo()
        }
        .refreshable {
            await viewModel.fetchAll()
            await userStore.fetchUserInfo()
        }
        .isTabBarVisible(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CoinLabel(userStore.user?.coins ?? 0)
            }
        }
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
