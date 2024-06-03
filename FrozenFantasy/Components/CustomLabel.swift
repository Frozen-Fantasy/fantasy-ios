//
//  CustomLabel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 21.05.2024.
//

import SwiftUI

struct CustomLabel: View {
    let text: String
    let image: String

    init(_ text: String, image: String) {
        self.text = text
        self.image = image
    }

    var body: some View {
        Label {
            Text(text)
                .font(.customBody1)
                .bold()
        } icon: {
            Image(image)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 19)
        }
        .labelStyle(.titleAndIcon)
        .foregroundStyle(.customBlack)
    }
}

#Preview {
    CustomLabel("Label", image: "icon:ratings")
}
