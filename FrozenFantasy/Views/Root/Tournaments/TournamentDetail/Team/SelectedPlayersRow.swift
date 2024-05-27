//
//  SelectedPlayersRow.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 24.05.2024.
//

import SwiftUI

struct SelectedPlayersRow: View {
    let players: Players

    init(_ players: Players) {
        self.players = players.sorted {
            $0.position.rawValue > $1.position.rawValue
                || $0.position.rawValue == $1.position.rawValue && $0.averageFP > $1.averageFP
        }
    }

    var body: some View {
        HStack(spacing: 8) {
            ForEach(players) { player in
                VStack(spacing: 4) {
                    CustomImage(url: player.photo) { image in
                        image.resizable()
                    }
                    .background(.white)
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(Circle())

                    Text(player.position.abbreviation)
                        .font(.customBody1)
                        .bold()
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 8)
                .background(player.position.color)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
            }

            ForEach(players.count ..< 6, id: \.self) { _ in
                VStack(spacing: 4) {
                    Circle()
                        .fill(.black.opacity(0.1))

                    Text(" ")
                        .font(.customBody1)
                        .bold()
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 8)
                .background(.black.opacity(0.15))
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
            }
        }
    }
}

#Preview {
    SelectedPlayersRow([.dummy])
        .padding()
}
