//
//  TeamView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 23.05.2024.
//

import SwiftUI

struct TeamView: View {
    let tournamentID: Int

    init(for tournamentID: Int) {
        self.tournamentID = tournamentID
    }

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
                    PlayerCard(player, isSelected: viewModel.createBinding(for: player))
                        .disabled(!viewModel.isEnabled(player))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("Создать команду")
        .animation(.default, value: viewModel.visiblePlayers)
        .task {
            viewModel.tournamentID = tournamentID
            await viewModel.fetchPlayers()
        }
    }
}

#Preview {
    NavigationView {
        TeamView(for: 0)
    }
}
