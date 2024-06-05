//
//  TournamentsView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct TournamentsView: View {
    @EnvironmentObject private var userStore: UserStore
    @StateObject private var viewModel = TournamentsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Активные")
                            .font(.customTitle1)
                            .foregroundStyle(.customBlack)

                        if viewModel.activeTournaments.isEmpty {
                            Text("Ждем следующий игровой день, заходите завтра!")
                                .font(.customTitle4)
                                .foregroundStyle(.customGray)
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.activeTournaments) { tournament in
                                    NavigationLink {
                                        TournamentDetailView(tournament)
                                    } label: {
                                        TournamentCard(tournament)
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Прошедшие")
                            .font(.customTitle1)
                            .foregroundStyle(.customBlack)

                        if viewModel.personalPastTournaments.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Вы пока не участвовали в турнирах")
                                    .font(.customTitle4)
                                    .foregroundStyle(.customGray)

                                Text("Зарегистриуйте команду в предстоящем турнире или посмотрите историю прошлых")
                                    .font(.customBody1)
                                    .foregroundStyle(.customGray)
                            }
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.personalPastTournaments) { tournament in
                                    NavigationLink {
                                        TournamentResultView(of: tournament)
                                    } label: {
                                        TournamentCard(tournament)
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(16)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Турниры")
            .animation(.default, value: viewModel.tournaments)
            .task {
                guard AppState.shared.currentScreen == .main
                else { return }

                await viewModel.getTournaments()
                await userStore.fetchUserInfo()
            }
            .refreshable {
                await viewModel.getTournaments()
                await userStore.fetchUserInfo()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        TournamentsHistoryView(viewModel.allPastTournaments)
                    } label: {
                        Image("icon:history")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    CoinLabel(userStore.user?.coins ?? 0)
                }
            }
        }
    }
}

#Preview {
    TournamentsView()
}
