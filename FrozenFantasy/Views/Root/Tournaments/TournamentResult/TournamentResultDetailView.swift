//
//  TournamentResultDetailView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 26.05.2024.
//

import SwiftUI

struct TournamentResultDetailView: View {
    let result: TournamentResult

    init(_ result: TournamentResult) {
        self.result = result
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(result.teamStats.sorted { $0.scoreFP > $1.scoreFP }) { playerStats in
                    PlayerCard(playerStats)
                }
            }
            .padding()
        }
        .navigationTitle("Команда \(result.nickname)")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FantasyPointLabel(result.scoreFP)
            }
        }
    }
}

#Preview {
    NavigationView {
        TournamentResultDetailView(.dummy)
    }
}
