//
//  FantasyPointLabel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 23.05.2024.
//

import SwiftUI

struct FantasyPointLabel: View {
    let value: Int

    init(_ value: Int) {
        self.value = value
    }

    var body: some View {
        Label {
            Text(value.formatted())
                .font(.customBodyMedium1)
                .foregroundStyle(.customBlack)
        } icon: {
            Image("icon:points")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 19)
                .foregroundStyle(.customBlue)
        }
        .labelStyle(.titleAndIcon)
    }
}

#Preview {
    FantasyPointLabel(1234567890)
}
