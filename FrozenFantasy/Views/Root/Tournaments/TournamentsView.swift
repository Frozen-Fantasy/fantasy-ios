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
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.tournaments) { tournament in
                        NavigationLink {
                            if tournament.status == .finished {
                                TournamentResultView(of: tournament)
                            } else {
                                TournamentDetailView(tournament)
                            }
                        } label: {
                            TournamentCard(tournament)
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Турниры")
            .task {
                await viewModel.getTournaments()
            }
            .refreshable {
                await viewModel.getTournaments()
            }
            .animation(.default, value: viewModel.tournaments)
        }
    }
}

#Preview {
    TournamentsView()
}
