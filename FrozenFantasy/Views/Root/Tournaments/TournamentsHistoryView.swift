//
//  TournamentsHistoryView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 06.06.2024.
//

import SwiftUI

struct TournamentsHistoryView: View {
    let tournaments: [Tournament]

    init(_ tournaments: [Tournament]) {
        self.tournaments = tournaments
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(tournaments) { tournament in
                    NavigationLink {
                        TournamentResultView(of: tournament)
                    } label: {
                        TournamentCard(tournament)
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle("История турниров")
    }
}

#Preview {
    NavigationView {
        TournamentsHistoryView([.dummy])
    }
}
