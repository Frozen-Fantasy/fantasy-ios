//
//  PlayerCard.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 25.05.2024.
//

import SwiftUI

struct PlayerCard: View {
    let player: PlayerCommon

    init(_ player: some PlayerCommon) {
        self.player = player
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                ZStack(alignment: .topTrailing) {
                    CustomImage(url: player.photo) { image in
                        GeometryReader { geometry in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height,
                                       alignment: .top)
                        }
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
                        }

                        Spacer()
                    }
                    .frame(width: 24)
                    .offset(x: 12)
                }
                .aspectRatio(1, contentMode: .fit)

                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text(player.name)
                            .font(.customTitle4)
                            .foregroundStyle(.customBlack)

                        if let player = player as? Player {
                            Text("#\(player.sweaterNumber)")
                                .font(.customBody1)
                                .bold()
                                .foregroundStyle(.customGray)
                        }
                    }

                    HStack(spacing: 4) {
                        CustomImage(url: player.teamLogo) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 32)

                        Text(player.teamName)
                            .font(.customBody1)
                            .foregroundStyle(.customBlack)
                    }
                }
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                if let playerStats = player as? PlayerStats {
                    FantasyPointLabel(playerStats.scoreFP)
                        .padding(.trailing, 12)
                }
            }
            .frame(height: 68)

            if let playerStats = player as? PlayerStats {
                HStack {
                    switch playerStats.position {
                    case .goaltender:
                        Spacer()
                        statLabel("SV", value: playerStats.saves)
                        Spacer()
                        statLabel("GA", value: playerStats.missed)
                        Spacer()
                        statLabel("PIM", value: playerStats.pims)
                        Spacer()
                        if playerStats.shutout {
                            Text("SO")
                            Spacer()
                        }
                    case .defender, .forward:
                        Spacer()
                        statLabel("G", value: playerStats.goals)
                        Spacer()
                        statLabel("A", value: playerStats.assists)
                        Spacer()
                        statLabel("HIT", value: playerStats.missed)
                        Spacer()
                        statLabel("S", value: playerStats.shots)
                        Spacer()
                        statLabel("PIM", value: playerStats.pims)
                        Spacer()
                    }
                }
                .font(.customBody1)
                .foregroundColor(.white)
                .padding(.vertical, 2)
                .background(player.position.color)
            }
        }
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
    }

    @ViewBuilder private func statLabel(_ title: String, value: Int) -> some View {
        HStack(spacing: 8) {
            Text(title)
            Text(value.formatted())
                .bold()
        }
    }
}

#Preview {
    VStack {
        PlayerCard(Player.dummy)
        PlayerCard(PlayerStats.dummy)
    }
    .padding()
}
