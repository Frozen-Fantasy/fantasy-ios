//
//  MatchCard.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 20.05.2024.
//

import SDWebImageSwiftUI
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

    private var statusText: String {
        switch match.status {
        case .notStarted:
            match.startsAt.formatted(date: .long, time: .shortened)
        case .started:
            "Идет сейчас"
        case .finished:
            "Завершён"
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            WebImage(url: match.homeTeamLogo) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
            .antialiased(true)
            .transition(.fade)
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

                Text(statusText)
                    .font(.customCaption1)
                    .foregroundStyle(match.status == .started ? .customGreen : .customGray)
            }

            WebImage(url: match.awayTeamLogo) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
            .antialiased(true)
            .transition(.fade)
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
    }
    .padding()
}
