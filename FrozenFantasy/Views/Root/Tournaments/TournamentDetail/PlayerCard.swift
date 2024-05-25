//
//  PlayerCard.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 25.05.2024.
//

import SDWebImageSwiftUI
import SwiftUI

protocol PlayerCommon {
    var name: String { get }
    var photo: URL { get }
    var position: Position { get }
    var sweaterNumber: Int { get }
    var rarity: Rarity { get }

    var teamName: String { get }
    var teamLogo: URL { get }
}

extension Player: PlayerCommon {}

struct PlayerCard: View {
    let player: PlayerCommon

    init(_ player: some PlayerCommon) {
        self.player = player
    }

    var body: some View {
        HStack(spacing: 16) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: player.photo) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .aspectRatio(1, contentMode: .fit)
                }

                VStack(spacing: 2) {
                    Text(player.position.abbreviation)
                        .font(.customCaption1)
                        .bold()
                        .foregroundStyle(.white)
                        .padding([.horizontal, .bottom], 4)
                        .background(player.position.color)
                        .clipShape(RoundedRectangle(cornerRadius: 2))

                    if player.rarity != .none {
                        Image("icon:double-arrow-up")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(player.rarity.color)
                            .frame(width: 24)
                    }

                    Spacer()
                }
                .offset(x: 8)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(player.name)
                        .font(.customTitle4)
                        .foregroundStyle(.customBlack)
                    Text("#\(player.sweaterNumber)")
                        .font(.customBody1)
                        .bold()
                        .foregroundStyle(.customGray)
                }

                HStack(spacing: 4) {
                    WebImage(url: player.teamLogo) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                    .antialiased(true)
                    .transition(.fade)
                    .aspectRatio(1.5, contentMode: .fit)

                    Text(player.teamName)
                        .font(.customBody1)
                        .foregroundStyle(.customBlack)
                }
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
        }
        .frame(height: 68)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
    }
}

#Preview {
    PlayerCard(Player.dummy)
        .padding()
}
