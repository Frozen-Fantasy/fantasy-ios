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

    var positionColor: Color {
        switch player.position {
        case .goaltender:
            .customBlack
        case .defender:
            .customBlue
        case .forward:
            .customOrange
        }
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

                Text(player.position.abbreviation)
                    .font(.customCaption1)
                    .bold()
                    .foregroundStyle(.white)
                    .padding([.horizontal, .bottom], 4)
                    .background(positionColor)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                    .offset(x: 4)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(player.name)
                    .font(.customTitle4)
                    .foregroundStyle(.customBlack)

                HStack(alignment: .firstTextBaseline) {
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("AvFP")
                            .font(.customBody1)
                            .foregroundStyle(.customBlack)

                        FantasyPointLabel(player.averageFP)
                    }
                    .frame(width: 100, alignment: .leading)

                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("Cost")
                            .font(.customBody1)
                            .foregroundStyle(.customBlack)

                        Text(player.cost
                                .formatted(.currency(code: "USD")
                                            .rounded(rule: .toNearestOrAwayFromZero,
                                                     increment: 0.1)))
                            .font(.customBody1)
                            .bold()
                            .foregroundStyle(.customBlack)
                    }
                }
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)

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
