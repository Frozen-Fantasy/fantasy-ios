//
//  MatchCardView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 20.05.2024.
//

import SwiftUI

struct MatchCardView: View {
    let match: Match

    init(_ match: Match) {
        self.match = match
    }

    var body: some View {
        HStack(spacing: 0) {
            Image("team:BUF")
                .resizable()
                .scaledToFit()
                .frame(height: 48)
                .padding(4)

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text(match.homeTeamAbbr)
                        .font(.customTitle2)
                    Spacer()

                    Text("\(match.homeTeamScore) : \(match.awayTeamScore)")
                        .font(.customTitle3)

                    Spacer()
                    Text(match.awayTeamAbbr)
                        .font(.customTitle2)
                    Spacer()
                }

                Text(Date(timeIntervalSince1970: match.startsAt / 1000)
                        .formatted(date: .long, time: .shortened))
                    .font(.customCaption1)
                    .foregroundStyle(.customGray)
            }

            Image("team:DET")
                .resizable()
                .scaledToFit()
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
    MatchCardView(.dummy)
        .padding()
}
