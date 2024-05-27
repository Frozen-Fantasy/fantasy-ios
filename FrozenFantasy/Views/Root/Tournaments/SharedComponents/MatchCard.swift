//
//  MatchCard.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 20.05.2024.
//

import SwiftUI

struct MatchCard: View {
    let match: Match

    init(_ match: Match) {
        self.match = match
    }

    private var scoreText: String {
        if match.status == .notStarted {
            "– : –"
        } else {
            "\(match.homeTeamScore) : \(match.awayTeamScore)"
        }
    }

    private var statusLabel: some View {
        switch match.status {
        case .notStarted:
            Text(match.startsAt.formatted(date: .long, time: .shortened))
                .font(.customCaption1)
                .foregroundStyle(.customBlue)
        case .started where match.endsAt > .now:
            Text("Идет сейчас")
                .font(.customCaption1)
                .foregroundStyle(.customGreen)
        case .started, .finished:
            Text("Завершён")
                .font(.customCaption1)
                .foregroundStyle(.customGray)
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            CustomImage(url: match.homeTeamLogo) { image in
                image.resizable()
            }
            .aspectRatio(1.5, contentMode: .fit)
            .frame(height: 48)
            .padding(4)

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text(match.homeTeamAbbr)
                        .font(.customTitle2)
                    Spacer()

                    Text(scoreText)
                        .font(.customTitle3)

                    Spacer()
                    Text(match.awayTeamAbbr)
                        .font(.customTitle2)
                    Spacer()
                }

                statusLabel
                    .font(.customCaption1)
            }

            CustomImage(url: match.awayTeamLogo) { image in
                image.resizable()
            }
            .aspectRatio(1.5, contentMode: .fit)
            .frame(height: 48)
            .padding(4)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
    }
}

#Preview {
    VStack {
        MatchCard(.dummy)
        MatchCard({
            var match: Match = .dummy
            match.status = .started
            return match
        }())
        MatchCard({
            var match: Match = .dummy
            match.status = .finished
            return match
        }())
        MatchCard({
            var match: Match = .dummy
            match.homeTeamLogo = URL(string: "https://example.com")!
            match.awayTeamLogo = URL(string: "https://example.com")!
            return match
        }())
    }
    .padding()
}
