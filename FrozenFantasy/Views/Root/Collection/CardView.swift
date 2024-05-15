//
//  CardView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 08.05.2024.
//

import SwiftUI

struct CardView: View {
    let card: Card

    private var playerName: String {
        let components = card.name.split(separator: " ")
        return components[0].prefix(1) + ". " + components[1]
    }

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                AsyncImage(url: card.photo) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                }

                Text(playerName)
                    .font(.customBody1)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(card.rarity == .silver ? .gray : .customYellow)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 4)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 2, y: 2)
                    .padding(.bottom, 8)
            }
        }
        .background(card.rarity == .silver ? .gray : .customYellow)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(color: .black.opacity(0.2), radius: 8, x: 2, y: 2)
    }
}

#Preview {
    HStack(spacing: 24) {
        CardView(card: .dummy)
        CardView(card: {
            var card = Card.dummy
            card.rarity = .gold
            return card
        }())
    }
    .padding()
}
