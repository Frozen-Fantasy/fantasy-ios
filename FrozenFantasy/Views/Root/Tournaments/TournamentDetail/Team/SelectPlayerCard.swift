//
//  SelectPlayerCard.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 23.05.2024.
//

import SwiftUI

struct SelectPlayerCard: View {
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
                CustomImage(url: player.photo) { image in
                    image
                        .resizable()
                        .scaledToFit()
                }
                .aspectRatio(1, contentMode: .fit)

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
        SelectPlayerCard(.dummy, isSelected: .constant(false))
        SelectPlayerCard(.dummy, isSelected: .constant(true))

        Group {
            SelectPlayerCard(.dummy, isSelected: .constant(false))
            SelectPlayerCard(.dummy, isSelected: .constant(true))
        }
        .disabled(true)
    }
    .padding()
}
