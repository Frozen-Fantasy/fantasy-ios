//
//  TournamentResultView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 25.05.2024.
//

import SwiftUI

struct TournamentResultView: View {
    @StateObject var viewModel = TournamentResultViewModel()

    let tournament: Tournament
    init(of tournament: Tournament) {
        self.tournament = tournament
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                TournamentInfo(tournament)
                TournamentMatches(viewModel.matches)

                if tournament.players > 0 {
                    ratings
                } else {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Рейтинг")
                            .font(.customTitle1)
                            .foregroundStyle(.customBlack)

                        Text("В туринре не было участников")
                            .font(.customBody1)
                            .bold()
                            .foregroundStyle(.customGray)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(tournament.title)
        .animation(.default.speed(1.5), value: viewModel.results)
        .animation(.default.speed(1.5), value: viewModel.matches)
        .task {
            viewModel.tournament = tournament
            await viewModel.fetchMatches()
            if tournament.players > 0 {
                await viewModel.fetchResult()
            }
        }
    }

    private var ratings: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Рейтинг")
                .font(.customTitle1)
                .foregroundStyle(.customBlack)

            VStack(spacing: 12) {
                ForEach(viewModel.results) { result in
                    NavigationLink {
                        TournamentResultDetailView(result)
                    } label: {
                        ResultCard(result)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        TournamentResultView(of: .dummy)
    }
}
