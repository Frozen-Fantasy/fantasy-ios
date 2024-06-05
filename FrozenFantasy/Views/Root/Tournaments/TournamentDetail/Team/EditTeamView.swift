//
//  EditTeamView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 23.05.2024.
//

import SwiftUI
import SwiftUIIntrospect

struct EditTeamView: View {
    @EnvironmentObject private var userStore: UserStore
    @StateObject private var viewModel = EditTeamViewModel()
    @Environment(\.dismiss) private var dismiss

    let tournament: Tournament
    let selectedPlayers: Players

    init(of tournament: Tournament, currentTeam: Players = []) {
        self.tournament = tournament
        self.selectedPlayers = currentTeam
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack {
                    Picker("Позиция", selection: $viewModel.selectedPosition) {
                        Text("Все").tag(Position?.none)
                        Text("Форварды").tag(Position?.some(.forward))
                        Text("Защитники").tag(Position?.some(.defender))
                        Text("Вратари").tag(Position?.some(.goaltender))
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom, 12)

                    ForEach(viewModel.visiblePlayers) { player in
                        SelectPlayerCard(player, isSelected: viewModel.createBinding(for: player))
                            .disabled(!viewModel.isAvailable(player: player))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 64) /// Additional room after the list
            }
            .padding(.bottom, -24) /// Allows overlapping by the bottom view

            VStack(spacing: 16) {
                HStack(alignment: .firstTextBaseline) {
                    HStack {
                        Text("Sum AvFP")
                            .font(.customBody1)
                            .foregroundStyle(.customBlack)

                        FantasyPointLabel(viewModel.selectedPlayers.reduce(0.0) { acc, player in
                            acc + player.averageFP
                        })
                    }

                    Spacer()

                    Text(viewModel.currentBudget.formatted(.currency(code: "USD"))
                            + " / "
                            + Constants.Tournaments.maxBudget.formatted(.currency(code: "USD"))
                    )
                    .font(.customBody1)
                    .foregroundStyle(.customBlack)
                }

                SelectedPlayersRow(Array(viewModel.selectedPlayers))

                Button {
                    Task {
                        if await viewModel.setTeam(isNew: !tournament.participating) {
                            await MainActor.run {
                                dismiss()
                            }
                        }
                    }
                } label: {
                    if tournament.participating {
                        Text("Сохранить изменения")
                    } else {
                        HStack(alignment: .firstTextBaseline) {
                            Text("Зарегистрироваться")

                            Label {
                                Text(tournament.deposit.formatted())
                                    .font(.customBodyMedium1)
                                    .foregroundStyle(.white)
                            } icon: {
                                Image("icon:coins")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 19)
                                    .foregroundStyle(.customYellow)
                            }
                            .labelStyle(.titleAndIcon)
                        }
                    }
                }
                .buttonStyle(.custom)
                .disabled(!viewModel.canRegister)
            }
            .padding(16)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 24)
            )
            .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 0)
            .mask(Rectangle().padding(.top, -40))
        }
        .navigationTitle(tournament.participating ? "Измените команду" : "Соберите команду")
        .animation(.default, value: viewModel.visiblePlayers)
        .animation(.default, value: viewModel.selectedPlayers)
        .task {
            viewModel.tournamentID = tournament.id
            viewModel.selectedPlayers = .init(selectedPlayers)
            await viewModel.fetchPlayers()
            await userStore.fetchUserInfo()
        }
        .isTabBarVisible(false)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CoinLabel(userStore.user?.coins ?? 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        EditTeamView(of: .dummy)
    }
}
