//
//  CardView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 08.05.2024.
//

import SwiftUI

struct CollectionCardView: View {
    @Binding var card: CollectionCard
    let openCardHandler: (Int) async -> Void

    init(_ card: Binding<CollectionCard>, openCardHandler: @escaping (Int) async -> Void) {
        self._card = card
        self.openCardHandler = openCardHandler
    }

    private var playerName: String {
        let components = card.name.split(separator: " ")
        return components[0].prefix(1) + ". " + components[1]
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                CustomImage(url: card.photo) { image in
                    GeometryReader { geometry in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height,
                                   alignment: .top)
                    }
                }

                HStack(alignment: .top) {
                    VStack(spacing: 4) {
                        Image("logo:\(card.league.title)")
                            .resizable()
                            .scaledToFit()

                        CustomImage(url: card.teamLogo) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        }
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
        .overlay {
            if !card.unpacked {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)

                Button("Открыть") {
                    card.unpacked = true
                    Task { await openCardHandler(card.id) }
                }
                .buttonStyle(.custom)
            }
        }
        .animation(.default, value: card.unpacked)
    }
}

#Preview {
    HStack(spacing: 24) {
        CollectionCardView(.constant(.dummy)) { _ in }
        CollectionCardView(.constant({
            var card = CollectionCard.dummy
            card.photo = URL(string: "https://www.khl.ru/img/teamplayers_db/14133/35060.jpg")!
            card.rarity = .gold
            card.unpacked = true
            return card
        }())) { _ in }
    }
    .padding()
}
