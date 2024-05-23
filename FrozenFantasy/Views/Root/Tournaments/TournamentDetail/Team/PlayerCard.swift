//
//  PlayerCard.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 23.05.2024.
//

import SwiftUI

struct PlayerCard: View {
    let player: Player

    @Binding var isSelected: Bool
    @Environment(\.isEnabled) var isEnabled

    init(_ player: Player, isSelected: Binding<Bool>) {
        self.player = player
        self._isSelected = isSelected
    }

    var body: some View {
        HStack(spacing: 16) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: player.photo) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()

                Text("F")
                    .font(.customBody1)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.customOrange)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(player.name)
                    .font(.customTitle4)
                    .foregroundStyle(.customBlack)

                HStack(alignment: .firstTextBaseline, spacing: 12) {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("AvFP")
                            .font(.customBody1)
                            .foregroundStyle(.customBlack)

                        FantasyPointLabel(player.averageFP)
                    }

                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("Cost")
                            .font(.customBody1)
                            .foregroundStyle(.customBlack)

                        Text(player.cost.formatted(.currency(code: "USD").rounded(rule: .down, increment: 1)))
                            .font(.customBody1)
                            .bold()
                            .foregroundStyle(.customBlack)
                    }
                }
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)

            Button {
                isSelected.toggle()
            } label: {
                Image(isSelected ? "icon:trash" : "icon:plus")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .padding(8)
            }
            .aspectRatio(2 / 3, contentMode: .fit)
            .frame(maxHeight: .infinity)
            .background(isSelected ? .customRed : (isEnabled ? .customBlue : .customGray))
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
    VStack {
        PlayerCard(.dummy, isSelected: .constant(false))
        PlayerCard(.dummy, isSelected: .constant(true))

        Group {
            PlayerCard(.dummy, isSelected: .constant(false))
            PlayerCard(.dummy, isSelected: .constant(true))
        }
        .disabled(true)
    }
    .padding()
}
