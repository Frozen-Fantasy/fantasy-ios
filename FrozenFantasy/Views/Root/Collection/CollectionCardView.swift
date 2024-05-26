//
//  CardView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 08.05.2024.
//

import SDWebImageSwiftUI
import SwiftUI

struct CollectionCardView: View {
    let card: CollectionCard

    private var playerName: String {
        let components = card.name.split(separator: " ")
        return components[0].prefix(1) + ". " + components[1]
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                AsyncImage(url: card.photo) { image in
                    GeometryReader { geometry in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height,
                                   alignment: .top)
                    }
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }

                HStack(alignment: .top) {
                    VStack(spacing: 4) {
                        Image("logo:\(card.league.title)")
                            .resizable()
                            .scaledToFit()

                        WebImage(url: card.teamLogo)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 40)
                    .padding(4)

                    Spacer()

                    Text(card.position.abbreviation)
                        .font(.customTitle4)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(card.position.color)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(8)
                }
            }
            .aspectRatio(1, contentMode: .fit)

            VStack(spacing: 4) {
                Text(card.name)
                    .font(.customTitle4)
                    .lineLimit(1)
                    .foregroundStyle(.white)

                Text("\(card.multiplicator.formatted()) × \(card.bonusMetricName)")
                    .font(.customBody1)
                    .bold()
                    .lineLimit(1)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 4)
            .padding(.bottom, 8)
            .background(card.rarity.color)
        }
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
    }
}

#Preview {
    HStack(spacing: 24) {
        CollectionCardView(card: .dummy)
        CollectionCardView(card: {
            var card = CollectionCard.dummy
            card.photo = URL(string: "https://www.khl.ru/img/teamplayers_db/14133/35060.jpg")!
            card.rarity = .gold
            return card
        }())
    }
    .padding()
}
