//
//  TournamentResultView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 25.05.2024.
//

import SwiftUI

struct TournamentResultView: View {
    @StateObject var viewModel = TournamentsViewModel()

    let tournament: Tournament
    init(of tournament: Tournament) {
        self.tournament = tournament
    }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TournamentResultView(of: .dummy)
}
