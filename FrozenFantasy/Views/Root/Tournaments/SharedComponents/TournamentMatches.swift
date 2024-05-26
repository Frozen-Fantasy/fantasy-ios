//
//  TournamentMatches.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 26.05.2024.
//

import SwiftUI

struct TournamentMatches: View {
    let matches: Matches

    init(_ matches: Matches) {
        self.matches = matches
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Матчи")
                .font(.customTitle1)
                .foregroundStyle(.customBlack)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 16) {
                ForEach(matches) { match in
                    MatchCard(match)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    TournamentMatches([.dummy])
}
