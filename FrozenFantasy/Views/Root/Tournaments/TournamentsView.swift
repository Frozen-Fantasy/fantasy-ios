//
//  TournamentsView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct TournamentsView: View {
    @StateObject private var viewModel = TournamentsViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Exo2-Bold", size: 32)!]
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Exo2-SemiBold", size: 20)!]
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.tournaments) { tournament in
                        NavigationLink {
                            TournamentDetialView(tournament)
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
