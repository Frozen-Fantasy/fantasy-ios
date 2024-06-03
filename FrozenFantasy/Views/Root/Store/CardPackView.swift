//
//  CardPackView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.06.2024.
//

import SwiftUI

struct CardPackView: View {
    let cardPack: CollectionCardPack

    init(_ cardPack: CollectionCardPack) {
        self.cardPack = cardPack
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image("cardpack:\(cardPack.league.title.lowercased()):\(cardPack.rarity.string)")
                .resizable()
                .scaledToFit()

            ZStack(alignment: .leading) {
                Text("\n\n")
                    .font(.customBody1)
                    .bold()

                Text(cardPack.title)
                    .font(.customBody1)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 4)

            HStack(alignment: .firstTextBaseline) {
                CustomLabel(cardPack.cardCount.formatted(), image: "icon:cards")
                    .foregroundColor(cardPack.rarity.color)
                Spacer()
                CoinLabel(cardPack.price)
                Spacer()
            }

            Button("Купить") {}
                .buttonStyle(.custom)
        }
        .padding(12)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
    }
}

#Preview {
    HStack(spacing: 12) {
        CardPackView(.dummy)
        CardPackView(.init(
            title: "Набор золотых карточек НХЛ",
            image: URL(string: "https://i.postimg.cc/XYzzMZYg/nhl-gold.png")!,
            cardCount: 3,
            price: 700,
            league: .NHL,
            rarity: .gold
        ))
    }
    .padding()
}
