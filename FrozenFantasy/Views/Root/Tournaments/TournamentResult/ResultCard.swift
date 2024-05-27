//
//  ResultCard.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 26.05.2024.
//

import SwiftUI

struct ResultCard: View {
    let result: TournamentResult

    init(_ result: TournamentResult) {
        self.result = result
    }

    var body: some View {
        HStack {
            if result.place == 1 {
                Image("icon:trophy")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.customYellow)
                    .frame(width: 32, height: 20)
            } else {
                Text("#\(result.place)")
                    .font(.customBody1)
                    .foregroundStyle(.customGray)
                    .frame(width: 32)
            }

            CustomImage(url: result.photo) { image in
                image
                    .resizable()
                    .background(.white)
            }
            .scaledToFit()
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
            .frame(height: 32)

            Text(result.nickname)
                .font(.customTitle4)
                .foregroundColor(.customBlack)
                .lineLimit(1)

            Spacer()

            CoinLabel(result.coinsWon)

            Image("icon:chevron-right")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.customGray)
                .frame(height: 20)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
    }
}

#Preview {
    VStack(spacing: 12) {
        ResultCard(.dummy)
        ResultCard({
            var result: TournamentResult = .dummy
            result.place = 12
            return result
        }())
    }
    .padding()
}
