//
//  StatisticsView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject private var userStore: UserStore
    @StateObject var viewModel = StatisticsViewModel()

    @State var presentedPlayer: Player?

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.players) { player in
                        Button {
                            presentedPlayer = player
                        } label: {
                            PlayerCard(player)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Статистика")
            .animation(.default, value: viewModel.players)
            .task {
                await viewModel.fetchPlayers()
                await userStore.fetchUserInfo()
            }
            .refreshable {
                await viewModel.fetchPlayers()
                await userStore.fetchUserInfo()
            }
            .sheet(isPresented: Binding(
                    get: {
                        presentedPlayer != nil
                    }, set: { _ in
                        presentedPlayer = nil
                    })
            ) {
                StatisticsDetailView(presentedPlayer!)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CoinLabel(userStore.user?.coins ?? 0)
                }
            }
        }
    }
}

#Preview {
    StatisticsView()
}
