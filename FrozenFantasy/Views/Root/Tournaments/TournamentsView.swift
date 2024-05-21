//
//  TournamentsView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct TournamentsView: View {
    @StateObject private var viewModel = TournamentsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.tournaments) { tournament in
                        NavigationLink {
                            TournamentDetailView(tournament)
                        } label: {
                            TournamentCard(tournament)
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("Турниры")
            .task {
                await viewModel.getTournaments()
            }
        }
    }
}

#Preview {
    TournamentsView()
}
