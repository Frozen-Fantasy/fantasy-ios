//
//  ColorExtension.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 10.04.2024.
//

import Foundation
import SwiftUI

public extension Color {
    init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0)
    }

    init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}

public extension Color {
    static let customBlack = Color(hex: 0x2D2D2D)
    static let customGray = Color(hex: 0xAEAEAE)

    static let customBlue = Color(hex: 0x186FB6)
    static let customOrange = Color(hex: 0xFD6735)

    static let customGreen = Color(hex: 0x84BF56)
    static let customRed = Color(hex: 0xEC4034)

    static let customYellow = Color(hex: 0xFDB935)
    static let customSilver = Color(hex: 0x6F6F6F)
}

extension ShapeStyle where Self == Color {
    static var customBlack: Self { .customBlack }
    static var customGray: Self { .customGray }

    static var customBlue: Self { .customBlue }
    static var customOrange: Self { .customOrange }

    static var customGreen: Self { .customGreen }
    static var customRed: Self { .customRed }

    static var customYellow: Self { .customYellow }
    static var customSilver: Self { .customSilver }
}

#Preview {
    VStack {
        Text("Text")
            .foregroundStyle(.customBlack)
        Text("Caption")
            .foregroundStyle(.customGray)

        Text("Blue")
            .foregroundStyle(.customBlue)
        Text("Orange")
            .foregroundStyle(.customOrange)

        Text("Green")
            .foregroundStyle(.customGreen)
        Text("Red")
            .foregroundStyle(.customRed)

        Text("Yellow")
            .foregroundStyle(.customYellow)
    }
    .font(.largeTitle)
}
