//
//  CoinLabel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 21.05.2024.
//

import SwiftUI

struct CoinLabel: View {
    let value: Int

    init(_ price: Int) {
        self.value = price
    }

    var body: some View {
        Label {
            Text(value.formatted())
                .font(.customBodyMedium1)
                .foregroundStyle(.customBlack)
        } icon: {
            Image("icon:coins")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 19)
                .foregroundStyle(.customYellow)
        }
        .labelStyle(.titleAndIcon)
    }
}

#Preview {
    CoinLabel(1234567890)
}
