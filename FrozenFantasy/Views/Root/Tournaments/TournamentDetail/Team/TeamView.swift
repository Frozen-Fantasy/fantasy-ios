//
//  TeamView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 23.05.2024.
//

import SwiftUI

struct TeamView: View {
    @StateObject var viewModel = TeamViewModel()

    var body: some View {
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
                    PlayerCard(player, isSelected: .init(get: {
                        viewModel.selectedPlayers.contains(player)
                    }, set: { newValue in
                        if newValue {
                            viewModel.selectedPlayers.insert(player)
                        } else {
                            viewModel.selectedPlayers.remove(player)
                        }
                    }))
                    .disabled(!viewModel.canContain(player.position))
                }
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("Создать команду")
        .animation(.default, value: viewModel.visiblePlayers)
        .task {
            await viewModel.fetchPlayers()
        }
    }
}

#Preview {
    NavigationView {
        TeamView()
    }
}
