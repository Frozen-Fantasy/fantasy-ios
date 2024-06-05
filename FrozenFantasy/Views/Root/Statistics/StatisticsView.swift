//
//  StatisticsView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct StatisticsView: View {
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
            }
            .refreshable {
                await viewModel.fetchPlayers()
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
        }
    }
}

#Preview {
    StatisticsView()
}
